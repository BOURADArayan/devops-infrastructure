#!/bin/bash

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          Nettoyage de l'Infrastructure DevOps            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

read -p "⚠️  Voulez-vous vraiment arrêter et supprimer tous les containers ? (y/N): " confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "Annulé."
    exit 0
fi

echo ""
echo "Arrêt des services..."

# Arrêter les containers individuels
docker stop jenkins portainer sonarqube dashboard devops-demo 2>/dev/null || true
docker rm jenkins portainer sonarqube dashboard devops-demo 2>/dev/null || true

# Arrêter le monitoring stack
cd ../monitoring
docker-compose down

echo ""
echo "✅ Tous les services ont été arrêtés"
echo ""

read -p "Voulez-vous également supprimer les volumes Docker ? (y/N): " clean_volumes

if [[ $clean_volumes =~ ^[Yy]$ ]]; then
    echo "Suppression des volumes..."
    docker volume rm jenkins_home portainer_data sonarqube_data \
        prometheus-data grafana-data 2>/dev/null || true
    echo "✅ Volumes supprimés"
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "Nettoyage terminé"
echo "═══════════════════════════════════════════════════════════"

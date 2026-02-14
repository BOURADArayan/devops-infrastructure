#!/bin/bash

set -e

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          Déploiement de l'Infrastructure DevOps          ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Fonction pour vérifier un service
check_service() {
    local service=$1
    local port=$2
    
    echo -n "Vérification de $service sur le port $port... "
    if timeout 5 curl -s http://localhost:$port > /dev/null 2>&1; then
        echo "✅"
    else
        echo "❌"
    fi
}

# 1. Déployer le monitoring
echo "1️⃣  Déploiement du Monitoring Stack..."
cd ../monitoring
docker-compose up -d
echo "✅ Monitoring déployé"
echo ""

# 2. Déployer l'application
echo "2️⃣  Build et déploiement de l'application..."
cd ../app
docker build -t devops-demo-app:latest .
docker stop devops-demo 2>/dev/null || true
docker rm devops-demo 2>/dev/null || true
docker run -d --name devops-demo -p 3001:3000 --restart unless-stopped devops-demo-app:latest
echo "✅ Application déployée"
echo ""

# 3. Déployer le dashboard
echo "3️⃣  Déploiement du Dashboard..."
cd ../dashboard
docker stop dashboard 2>/dev/null || true
docker rm dashboard 2>/dev/null || true
docker run -d --name dashboard --restart unless-stopped \
    -p 1122:80 -v $(pwd):/usr/share/nginx/html:ro nginx:alpine
echo "✅ Dashboard déployé"
echo ""

# 4. Vérification
echo "4️⃣  Vérification des services..."
echo ""
check_service "Prometheus" "9090"
check_service "Grafana" "3000"
check_service "Application" "3001"
check_service "Dashboard" "1122"
echo ""

PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)
echo "═══════════════════════════════════════════════════════════"
echo "✅ Déploiement terminé avec succès !"
echo ""
echo "Services accessibles :"
echo "  📊 Grafana:      http://$PUBLIC_IP:3000"
echo "  📈 Prometheus:   http://$PUBLIC_IP:9090"
echo "  🚀 Application:  http://$PUBLIC_IP:3001"
echo "  🌐 Dashboard:    http://$PUBLIC_IP:1122"
echo "═══════════════════════════════════════════════════════════"

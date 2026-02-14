#!/bin/bash

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          Vérification de la Structure du Projet          ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

check_file() {
    if [ -f "$1" ]; then
        echo "✅ $1"
    else
        echo "❌ $1 (manquant)"
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo "✅ $1/"
    else
        echo "❌ $1/ (manquant)"
    fi
}

echo "📁 Dossiers:"
check_dir "app"
check_dir "monitoring"
check_dir "kubernetes"
check_dir "scripts"
check_dir "docs"
check_dir "dashboard"
echo ""

echo "📄 Fichiers racine:"
check_file "README.md"
check_file "docker-compose.yml"
check_file ".gitignore"
check_file "LICENSE"
check_file "CHANGELOG.md"
check_file "CONTRIBUTING.md"
echo ""

echo "📄 Application:"
check_file "app/app.js"
check_file "app/package.json"
check_file "app/Dockerfile"
check_file "app/Jenkinsfile"
echo ""

echo "📄 Monitoring:"
check_file "monitoring/docker-compose.yml"
check_file "monitoring/prometheus.yml"
check_file "monitoring/alert.rules.yml"
echo ""

echo "📄 Kubernetes:"
check_file "kubernetes/namespace.yaml"
check_file "kubernetes/deployment.yaml"
check_file "kubernetes/service.yaml"
check_file "kubernetes/configmap.yaml"
echo ""

echo "📄 Scripts:"
check_file "scripts/install-all.sh"
check_file "scripts/deploy.sh"
check_file "scripts/cleanup.sh"
check_file "scripts/backup.sh"
check_file "scripts/monitor.sh"
echo ""

echo "📄 Documentation:"
check_file "docs/INSTALLATION.md"
check_file "docs/CONFIGURATION.md"
check_file "docs/TROUBLESHOOTING.md"
echo ""

echo "═══════════════════════════════════════════════════════════"
echo "Vérification terminée"

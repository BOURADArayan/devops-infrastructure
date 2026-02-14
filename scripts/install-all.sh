#!/bin/bash

################################################################################
# Script d'installation DevOps complet
# Auteur: DevOps Team
# Description: Installation automatisée de l'environnement DevOps complet
################################################################################

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_message() {
    echo -e "${BLUE}===================================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${BLUE}===================================================${NC}"
}

print_success() {
    echo -e "${GREEN}[✓] $1${NC}"
}

print_error() {
    echo -e "${RED}[✗] $1${NC}"
}

# Vérifier que le script est exécuté en tant que root ou avec sudo
if [ "$EUID" -ne 0 ] && [ -z "$SUDO_USER" ]; then 
    print_error "Ce script nécessite des privilèges sudo"
    echo "Exécutez: sudo $0"
    exit 1
fi

print_message "Installation DevOps - Démarrage"

# 1. Mise à jour du système
print_message "1. Mise à jour du système"
apt update && apt upgrade -y
print_success "Système mis à jour"

# 2. Installation de Docker
print_message "2. Installation de Docker"
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    systemctl start docker
    systemctl enable docker
    usermod -aG docker $SUDO_USER
    print_success "Docker installé"
else
    print_success "Docker déjà installé"
fi

# 3. Installation de Docker Compose
print_message "3. Installation de Docker Compose"
if ! command -v docker-compose &> /dev/null; then
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    print_success "Docker Compose installé"
else
    print_success "Docker Compose déjà installé"
fi

# 4. Installation de Kubernetes (K3s)
print_message "4. Installation de Kubernetes (K3s)"
if ! command -v kubectl &> /dev/null; then
    curl -sfL https://get.k3s.io | sh -
    mkdir -p /home/$SUDO_USER/.kube
    cp /etc/rancher/k3s/k3s.yaml /home/$SUDO_USER/.kube/config
    chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.kube/config
    print_success "K3s installé"
else
    print_success "Kubernetes déjà installé"
fi

# 5. Installation de Helm
print_message "5. Installation de Helm"
if ! command -v helm &> /dev/null; then
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    print_success "Helm installé"
else
    print_success "Helm déjà installé"
fi

# 6. Installation d'Ansible
print_message "6. Installation d'Ansible"
if ! command -v ansible &> /dev/null; then
    apt install -y ansible
    print_success "Ansible installé"
else
    print_success "Ansible déjà installé"
fi

# 7. Installation de Terraform
print_message "7. Installation de Terraform"
if ! command -v terraform &> /dev/null; then
    wget -O- https://apt.releases.hashicorp.com/gpg | \
        gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        tee /etc/apt/sources.list.d/hashicorp.list
    apt update
    apt install -y terraform
    print_success "Terraform installé"
else
    print_success "Terraform déjà installé"
fi

print_message "Installation terminée avec succès !"
echo ""
echo "Prochaines étapes:"
echo "  1. Reconnectez-vous pour appliquer les permissions Docker"
echo "  2. Déployez les services: cd monitoring && docker-compose up -d"
echo "  3. Vérifiez: docker ps"

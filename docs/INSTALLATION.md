# 📖 Guide d'Installation

## Prérequis

- AWS EC2 Instance (Ubuntu 22.04+)
- 8GB RAM minimum
- 16 CPU cores recommandés
- 50GB de stockage
- Accès root ou sudo

## Installation Rapide

### 1. Cloner le Repository
```bash
git clone https://github.com/VOTRE-USERNAME/devops-infrastructure.git
cd devops-infrastructure
```

### 2. Installer les Outils de Base
```bash
cd scripts
sudo ./install-all.sh
```

**⚠️ Important** : Reconnectez-vous après l'installation pour appliquer les permissions Docker.

### 3. Déployer les Services
```bash
cd scripts
./deploy.sh
```

### 4. Vérification
```bash
docker ps
```

Vous devriez voir tous les containers en cours d'exécution.

## Configuration des Ports AWS Security Group

Ouvrez ces ports dans votre Security Group AWS :

| Port | Service |
|------|---------|
| 22 | SSH |
| 1122 | Dashboard |
| 3000 | Grafana |
| 3001 | Demo App |
| 8080, 50000 | Jenkins |
| 9000, 9443 | Portainer |
| 9002 | SonarQube |
| 9090 | Prometheus |
| 9100 | Node Exporter |
| 8082 | cAdvisor |
| 30080 | ArgoCD |

## Installation Manuelle

### Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

### Docker Compose
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### Kubernetes (K3s)
```bash
curl -sfL https://get.k3s.io | sh -
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
```

### Monitoring Stack
```bash
cd monitoring
docker-compose up -d
```

### Application
```bash
cd app
docker build -t devops-demo-app:latest .
docker run -d --name devops-demo -p 3001:3000 devops-demo-app:latest
```

## Accès aux Services

Remplacez `YOUR_IP` par votre IP publique AWS.

- **Dashboard** : http://YOUR_IP:1122
- **Jenkins** : http://YOUR_IP:8080
- **Grafana** : http://YOUR_IP:3000 (admin/admin)
- **Prometheus** : http://YOUR_IP:9090
- **Application** : http://YOUR_IP:3001

## Dépannage

Voir [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

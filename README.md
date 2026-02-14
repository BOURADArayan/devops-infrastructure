# 🚀 DevOps Infrastructure Complete

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-326CE5)](https://k3s.io/)
[![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939)](https://www.jenkins.io/)

Infrastructure DevOps complète avec CI/CD, monitoring, et orchestration Kubernetes - Prête pour la production.

![DevOps Architecture](docs/architecture-diagram.png)

## 📋 Table des Matières

- [Vue d'ensemble](#vue-densemble)
- [Architecture](#architecture)
- [Services Déployés](#services-déployés)
- [Installation Rapide](#installation-rapide)
- [Configuration](#configuration)
- [Utilisation](#utilisation)
- [Documentation](#documentation)
- [Contribution](#contribution)

## 🎯 Vue d'ensemble

Cette infrastructure DevOps fournit une solution complète et prête à l'emploi pour :

- ✅ **CI/CD automatisé** avec Jenkins
- ✅ **Monitoring temps réel** avec Prometheus & Grafana
- ✅ **Orchestration de containers** avec Kubernetes (K3s)
- ✅ **GitOps** avec ArgoCD
- ✅ **Analyse de code** avec SonarQube
- ✅ **Gestion Docker** avec Portainer
- ✅ **Infrastructure as Code** avec Terraform & Ansible

## 🏗️ Architecture
```
┌─────────────────────────────────────────────────────────────┐
│                    AWS EC2 Ubuntu Instance                  │
│                                                             │
│  ├── Jenkins (CI/CD)              :8080                    │
│  ├── Portainer (Docker GUI)       :9000                    │
│  ├── Grafana (Monitoring)         :3000                    │
│  ├── Prometheus (Metrics)         :9090                    │
│  ├── SonarQube (Code Quality)     :9002                    │
│  ├── ArgoCD (GitOps)              :30080                   │
│  ├── Demo App (Node.js)           :3001                    │
│  └── Dashboard (Web)              :1122                    │
│                                                             │
│  Kubernetes (K3s) + Docker Engine                          │
└─────────────────────────────────────────────────────────────┘
```

## 🛠️ Services Déployés

| Service | Port(s) | Description | Credentials |
|---------|---------|-------------|-------------|
| 🔧 **Jenkins** | 8080, 50000 | CI/CD Pipeline Automation | admin / [initial password] |
| 🐳 **Portainer** | 9000, 9443 | Docker Container Management | admin / [set on first login] |
| 📊 **Grafana** | 3000 | Monitoring Dashboards | admin / admin |
| 📈 **Prometheus** | 9090 | Metrics Collection & Storage | - |
| 🔍 **SonarQube** | 9002 | Code Quality Analysis | admin / admin |
| 🔄 **ArgoCD** | 30080 | GitOps Continuous Delivery | admin / [kubectl get secret] |
| 💻 **Node Exporter** | 9100 | System Metrics Exporter | - |
| 🐋 **cAdvisor** | 8082 | Container Metrics Analyzer | - |
| 🚀 **Demo App** | 3001 | Node.js Express Application | - |
| 🌐 **Dashboard** | 1122 | Web Dashboard | - |

## 📋 Prérequis

### Matériel (AWS EC2 Recommandé)

- **OS** : Ubuntu 22.04 LTS ou supérieur
- **RAM** : 8GB minimum (16GB recommandé)
- **CPU** : 4 cores minimum (16 cores recommandé)
- **Stockage** : 50GB minimum (100GB recommandé)
- **Network** : Connexion internet stable

### Logiciels

- Git
- Docker & Docker Compose (installé automatiquement)
- Kubernetes (K3s - installé automatiquement)
- Accès sudo

## 🚀 Installation Rapide

### Méthode 1 : Installation Automatique (Recommandé)
```bash
# 1. Cloner le repository
git clone https://github.com/VOTRE-USERNAME/devops-infrastructure.git
cd devops-infrastructure

# 2. Lancer l'installation complète
cd scripts
sudo ./install-all.sh

# 3. Reconnectez-vous pour appliquer les permissions Docker
exit
# Reconnectez-vous via SSH

# 4. Déployer les services
cd ~/devops-infrastructure/scripts
./deploy.sh
```

### Méthode 2 : Docker Compose (Tout en un)
```bash
# Cloner le repository
git clone https://github.com/VOTRE-USERNAME/devops-infrastructure.git
cd devops-infrastructure

# Démarrer tous les services
docker-compose up -d

# Vérifier
docker-compose ps
```

### Méthode 3 : Déploiement Kubernetes
```bash
# Appliquer les manifestes Kubernetes
kubectl apply -f kubernetes/

# Vérifier les pods
kubectl get pods -n devops-app

# Accéder à l'application
kubectl port-forward service/devops-demo-service 3001:3000 -n devops-app
```

## 🔧 Configuration

### Configuration AWS Security Group

Ouvrez ces ports dans votre AWS Security Group :
```bash
Ports à ouvrir :
- 22 (SSH)
- 1122 (Dashboard)
- 3000 (Grafana)
- 3001 (Demo App)
- 8080, 50000 (Jenkins)
- 8082 (cAdvisor)
- 9000, 9443 (Portainer)
- 9002 (SonarQube)
- 9090 (Prometheus)
- 9100 (Node Exporter)
- 30080 (ArgoCD)
```

### Configuration des Services

#### Jenkins
```bash
# Récupérer le mot de passe initial
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

#### ArgoCD
```bash
# Récupérer le mot de passe admin
kubectl -n argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d && echo
```

#### Grafana
- Login: `admin`
- Password: `admin` (à changer à la première connexion)

Voir [docs/CONFIGURATION.md](docs/CONFIGURATION.md) pour plus de détails.

## 📖 Utilisation

### Accès aux Services

Remplacez `YOUR_IP` par votre adresse IP publique AWS :

- **Dashboard Principal** : http://YOUR_IP:1122
- **Jenkins** : http://YOUR_IP:8080
- **Grafana** : http://YOUR_IP:3000
- **Prometheus** : http://YOUR_IP:9090
- **SonarQube** : http://YOUR_IP:9002
- **ArgoCD** : http://YOUR_IP:30080
- **Portainer** : http://YOUR_IP:9000
- **Demo Application** : http://YOUR_IP:3001

### Commandes Utiles
```bash
# Voir tous les containers
docker ps

# Voir les logs d'un service
docker logs -f <service_name>

# Redémarrer un service
docker restart <service_name>

# Monitoring des ressources
docker stats

# Kubernetes
kubectl get pods -A
kubectl get svc -A

# Scripts utiles
cd scripts
./monitor.sh      # Monitoring en temps réel
./backup.sh       # Backup de l'infrastructure
./cleanup.sh      # Nettoyage complet
```

## 📚 Documentation

- [📖 Guide d'Installation Complet](docs/INSTALLATION.md)
- [⚙️ Guide de Configuration](docs/CONFIGURATION.md)
- [🏗️ Architecture Détaillée](docs/ARCHITECTURE.md)
- [🔧 Guide de Dépannage](docs/TROUBLESHOOTING.md)

## 🔄 Workflow CI/CD
```
Developer Push Code
        ↓
    GitHub/GitLab
        ↓
    Jenkins (Poll/Webhook)
        ↓
    Build & Test (npm)
        ↓
    SonarQube Analysis
        ↓
    Docker Build
        ↓
    Deploy to Docker/K8s
        ↓
    ArgoCD Sync (GitOps)
        ↓
    Application Running
        ↓
    Prometheus Metrics
        ↓
    Grafana Dashboards
```

## 📊 Monitoring

### Dashboards Grafana Pré-configurés

- **Node Exporter Full** : Métriques système détaillées
- **Docker Container & Host** : Monitoring Docker
- **Jenkins Performance** : Métriques Jenkins
- **Kubernetes Cluster** : Overview du cluster K8s

### Métriques Collectées

- CPU, RAM, Disk, Network (Node Exporter)
- Container stats (cAdvisor)
- Jenkins builds, queue, jobs
- Application custom metrics

## 🔐 Sécurité

### Bonnes Pratiques Implémentées

- ✅ Containers isolés dans un réseau Docker
- ✅ Volumes persistants pour les données
- ✅ Restart policies configurées
- ✅ Health checks sur l'application
- ✅ Resource limits sur les containers
- ✅ Secrets management avec Kubernetes

### À Configurer

- [ ] Changer TOUS les mots de passe par défaut
- [ ] Configurer SSL/TLS (Let's Encrypt)
- [ ] Mettre en place l'authentification SSO
- [ ] Configurer des backups automatiques
- [ ] Activer les scans de sécurité des images

## 🤝 Contribution

Les contributions sont les bienvenues ! Merci de :

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📝 Changelog

Voir [CHANGELOG.md](CHANGELOG.md) pour l'historique des versions.

## 📄 License

Ce projet est sous licence MIT. Voir [LICENSE](LICENSE) pour plus de détails.

## 👨‍💻 Auteur

**Votre Nom**
- GitHub: [@votre-username](https://github.com/votre-username)
- LinkedIn: [Votre Profil](https://linkedin.com/in/votre-profil)
- Email: votre.email@example.com

## 🙏 Remerciements

- [Docker](https://www.docker.com/)
- [Kubernetes](https://kubernetes.io/)
- [Jenkins](https://www.jenkins.io/)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)
- [ArgoCD](https://argoproj.github.io/cd/)
- [SonarQube](https://www.sonarqube.org/)

---

**⭐ Si ce projet vous est utile, n'hésitez pas à lui donner une étoile !**

Made with ❤️ for the DevOps Community

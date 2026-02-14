# 🚀 DevOps Infrastructure Complete

<div align="center">

![DevOps](https://img.shields.io/badge/DevOps-Infrastructure-blue?style=for-the-badge&logo=kubernetes)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?style=for-the-badge&logo=grafana&logoColor=white)

**Infrastructure DevOps complète avec CI/CD, Monitoring et Orchestration Kubernetes**

[Installation](#-installation-rapide) •
[Documentation](#-documentation) •
[Architecture](#️-architecture) •
[Contribution](#-contribution)

</div>

---

## 📋 Table des Matières

- [Vue d'ensemble](#-vue-densemble)
- [Fonctionnalités](#-fonctionnalités)
- [Architecture](#️-architecture)
- [Services](#️-services-déployés)
- [Installation Rapide](#-installation-rapide)
- [Configuration](#-configuration)
- [Utilisation](#-utilisation)
- [Documentation](#-documentation)
- [Screenshots](#-screenshots)
- [Contribution](#-contribution)
- [License](#-license)

---

## 🎯 Vue d'ensemble

Cette infrastructure DevOps fournit une **solution complète et prête pour la production** comprenant :

- ✅ **CI/CD Pipeline** automatisé avec Jenkins
- ✅ **Monitoring temps réel** avec Prometheus & Grafana
- ✅ **Orchestration de containers** avec Kubernetes (K3s)
- ✅ **GitOps** avec ArgoCD
- ✅ **Analyse de code** avec SonarQube
- ✅ **Gestion Docker** avec Portainer
- ✅ **Infrastructure as Code** avec Terraform & Ansible
- ✅ **Dashboard web** centralisé

## ✨ Fonctionnalités

### CI/CD
- 🔄 Pipelines automatisés Jenkins
- 🔍 Analyse de qualité SonarQube
- 🐳 Build et push Docker automatiques
- ☸️ Déploiement Kubernetes via ArgoCD

### Monitoring
- 📊 Dashboards Grafana pré-configurés
- 📈 Métriques Prometheus
- 💻 Monitoring système (Node Exporter)
- 🐋 Métriques containers (cAdvisor)

### Infrastructure
- ⚙️ Déploiement en 1-click
- 🔒 Sécurisé par défaut
- 📦 Containerisé et portable
- 🔄 Auto-scaling & self-healing

## 🏗️ Architecture
```
┌─────────────────────────────────────────────────────────┐
│              AWS EC2 Ubuntu Instance                    │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Docker & Kubernetes (K3s)              │  │
│  │                                                  │  │
│  │  CI/CD          Monitoring        Management    │  │
│  │  ├─ Jenkins     ├─ Prometheus    ├─ Portainer  │  │
│  │  ├─ ArgoCD      ├─ Grafana       ├─ SonarQube  │  │
│  │  └─ GitLab R.   └─ Exporters     └─ Dashboard  │  │
│  │                                                  │  │
│  │  Application: Node.js Demo (Port 3001)          │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

Voir [docs/architecture-diagram.txt](docs/architecture-diagram.txt) pour le diagramme complet.

## 🛠️ Services Déployés

| Service | Port(s) | Description | Status |
|---------|---------|-------------|--------|
| 🔧 **Jenkins** | 8080, 50000 | CI/CD Pipeline | ![Status](https://img.shields.io/badge/status-operational-success) |
| 🐳 **Portainer** | 9000, 9443 | Docker Management | ![Status](https://img.shields.io/badge/status-operational-success) |
| 📊 **Grafana** | 3000 | Monitoring Dashboards | ![Status](https://img.shields.io/badge/status-operational-success) |
| 📈 **Prometheus** | 9090 | Metrics Collection | ![Status](https://img.shields.io/badge/status-operational-success) |
| 🔍 **SonarQube** | 9002 | Code Quality | ![Status](https://img.shields.io/badge/status-operational-success) |
| 🔄 **ArgoCD** | 30080 | GitOps CD | ![Status](https://img.shields.io/badge/status-operational-success) |
| 🚀 **Demo App** | 3001 | Node.js App | ![Status](https://img.shields.io/badge/status-operational-success) |
| 🌐 **Dashboard** | 1122 | Web Interface | ![Status](https://img.shields.io/badge/status-operational-success) |

## 🚀 Installation Rapide

### Prérequis

- Ubuntu 22.04+ (AWS EC2 recommandé)
- 8GB RAM minimum
- 4 CPU cores minimum
- 50GB de stockage
- Accès sudo

### Installation en 3 commandes
```bash
# 1. Cloner le repository
git clone https://github.com/VOTRE-USERNAME/devops-infrastructure.git
cd devops-infrastructure

# 2. Installer l'infrastructure
cd scripts && sudo ./install-all.sh

# 3. Déployer les services
./deploy.sh
```

### Installation via Docker Compose
```bash
# Tout en une commande
docker-compose up -d
```

### Déploiement Kubernetes
```bash
# Déployer sur K8s
kubectl apply -f kubernetes/

# Vérifier
kubectl get pods -n devops-app
```

## ⚙️ Configuration

### AWS Security Group

Ports à ouvrir :
```
22, 1122, 3000, 3001, 8080, 8082, 9000, 9002, 9090, 9100, 9443, 30080, 50000
```

### Credentials par défaut

| Service | Username | Password |
|---------|----------|----------|
| Jenkins | admin | (voir logs) |
| Grafana | admin | admin |
| SonarQube | admin | admin |
| ArgoCD | admin | (kubectl get secret) |
| Portainer | admin | (first login) |

⚠️ **Changez tous les mots de passe en production !**

## 📖 Utilisation

### Accès aux services

Remplacez `YOUR_IP` par votre IP publique :
```
Dashboard:   http://YOUR_IP:1122
Jenkins:     http://YOUR_IP:8080
Grafana:     http://YOUR_IP:3000
Prometheus:  http://YOUR_IP:9090
SonarQube:   http://YOUR_IP:9002
ArgoCD:      http://YOUR_IP:30080
Portainer:   http://YOUR_IP:9000
Demo App:    http://YOUR_IP:3001
```

### Commandes utiles
```bash
# Monitoring
./scripts/monitor.sh

# Backup
./scripts/backup.sh

# Cleanup
./scripts/cleanup.sh

# Logs
docker-compose logs -f [service]
```

## 📚 Documentation

- 📖 [Guide d'Installation](docs/INSTALLATION.md)
- ⚙️ [Configuration](docs/CONFIGURATION.md)
- 🔧 [Troubleshooting](docs/TROUBLESHOOTING.md)
- 📊 [Status du Projet](STATUS.md)

## 📸 Screenshots

### Dashboard
![Dashboard](docs/screenshots/dashboard.png)

### Grafana Monitoring
![Grafana](docs/screenshots/grafana.png)

### Jenkins Pipeline
![Jenkins](docs/screenshots/jenkins.png)

*Screenshots à ajouter*

## 🤝 Contribution

Les contributions sont les bienvenues ! Consultez [CONTRIBUTING.md](CONTRIBUTING.md)

### Quick Start
```bash
# Fork le projet
git clone https://github.com/votre-username/devops-infrastructure.git

# Créer une branche
git checkout -b feature/amazing-feature

# Commit
git commit -m 'feat: add amazing feature'

# Push
git push origin feature/amazing-feature

# Ouvrir une Pull Request
```

## 📝 Changelog

Voir [CHANGELOG.md](CHANGELOG.md)

## 📄 License

MIT License - voir [LICENSE](LICENSE)

## 👨‍💻 Auteur

**Votre Nom**

[![GitHub](https://img.shields.io/badge/GitHub-@votre--username-181717?style=flat&logo=github)](https://github.com/votre-username)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Votre%20Profil-0077B5?style=flat&logo=linkedin)](https://linkedin.com/in/votre-profil)
[![Email](https://img.shields.io/badge/Email-votre.email%40example.com-D14836?style=flat&logo=gmail&logoColor=white)](mailto:votre.email@example.com)

## 🙏 Remerciements

- [Docker](https://www.docker.com/)
- [Kubernetes](https://kubernetes.io/)
- [Jenkins](https://www.jenkins.io/)
- [Prometheus](https://prometheus.io/)
- [Grafana](https://grafana.com/)
- [ArgoCD](https://argoproj.github.io/)

---

<div align="center">

**⭐ Si ce projet vous est utile, n'hésitez pas à lui donner une étoile !**

Made with ❤️ for the DevOps Community

</div>

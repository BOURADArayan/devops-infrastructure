# ⚙️ Guide de Configuration

## Jenkins

### Configuration Initiale

1. Accédez à http://YOUR_IP:8080
2. Récupérez le mot de passe initial :
```bash
   docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
3. Installez les plugins suggérés
4. Créez un compte administrateur

### Configuration Docker dans Jenkins

1. **Manage Jenkins** → **Configure System**
2. Ajoutez Docker Cloud
3. Configurez l'accès à Docker Socket

### Plugins Recommandés

- Docker Pipeline
- Kubernetes
- Git
- Blue Ocean
- Prometheus metrics
- SonarQube Scanner

## Grafana

### Configuration Initiale

1. Accédez à http://YOUR_IP:3000
2. Login: admin / admin
3. Changez le mot de passe

### Ajouter Prometheus

1. **Configuration** → **Data Sources**
2. **Add data source** → **Prometheus**
3. URL: `http://prometheus:9090`
4. **Save & Test**

### Importer des Dashboards

Dashboards recommandés :
- Node Exporter Full (ID: 1860)
- Docker Container & Host (ID: 193)
- Jenkins Performance (ID: 9964)

## SonarQube

### Configuration Initiale

1. Accédez à http://YOUR_IP:9002
2. Login: admin / admin
3. Changez le mot de passe

### Générer un Token

1. **My Account** → **Security**
2. **Generate Token**
3. Sauvegardez le token pour Jenkins

## ArgoCD

### Récupérer le Mot de Passe
```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d && echo
```

### Configurer un Repository

1. **Settings** → **Repositories**
2. **Connect Repo**
3. Ajoutez votre repository GitHub

## Portainer

### Configuration Initiale

1. Accédez à http://YOUR_IP:9000
2. Créez un compte administrateur
3. Connectez à l'environnement Docker local

## Sécurité

### Changez TOUS les Mots de Passe par Défaut

- Jenkins: admin
- Grafana: admin / admin
- SonarQube: admin / admin
- ArgoCD: (via kubectl)
- Portainer: (première connexion)

### Configurez des Tokens API

Créez des tokens API au lieu d'utiliser des mots de passe :
- Jenkins: User → Configure → API Token
- SonarQube: My Account → Security → Generate Token

### Firewall (Optionnel)
```bash
sudo ufw allow 22/tcp
sudo ufw allow 8080/tcp
sudo ufw allow 3000/tcp
# ... autres ports
sudo ufw enable
```

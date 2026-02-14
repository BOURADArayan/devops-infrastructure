# 🔧 Guide de Dépannage

## Problèmes Courants

### Docker "Permission Denied"

**Symptôme** : `permission denied while trying to connect to the Docker daemon socket`

**Solution** :
```bash
sudo usermod -aG docker $USER
newgrp docker
# Ou reconnectez-vous en SSH
```

### Port Déjà Utilisé

**Symptôme** : `bind: address already in use`

**Solution** :
```bash
# Trouver le processus utilisant le port
sudo lsof -i :8080

# Arrêter le processus ou changer le port
```

### Container Ne Démarre Pas

**Solution** :
```bash
# Voir les logs
docker logs <container_name>

# Redémarrer le container
docker restart <container_name>

# Recréer le container
docker stop <container_name>
docker rm <container_name>
# Puis relancer la commande docker run
```

### SonarQube : Échec de Démarrage

**Symptôme** : SonarQube redémarre en boucle

**Solution** :
```bash
# Vérifier vm.max_map_count
sysctl vm.max_map_count

# Si < 262144, corriger :
sudo sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf

# Redémarrer SonarQube
docker restart sonarqube
```

### Jenkins : npm not found

**Solution** :
```bash
# Installer Node.js dans Jenkins
docker exec -u root jenkins bash -c '
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs
'

# Vérifier
docker exec jenkins node --version
docker exec jenkins npm --version
```

### Kubernetes Pods en Erreur

**Solution** :
```bash
# Voir les détails du pod
kubectl describe pod <pod_name> -n <namespace>

# Voir les logs
kubectl logs <pod_name> -n <namespace>

# Redémarrer le pod
kubectl delete pod <pod_name> -n <namespace>
```

### Espace Disque Plein

**Solution** :
```bash
# Vérifier l'espace
df -h

# Nettoyer Docker
docker system prune -a
docker volume prune

# Nettoyer les logs
sudo journalctl --vacuum-time=3d
```

### Service Inaccessible depuis l'Extérieur

**Vérifications** :

1. Container en cours d'exécution :
```bash
   docker ps | grep <service_name>
```

2. Port en écoute :
```bash
   sudo netstat -tulpn | grep <port>
```

3. AWS Security Group :
   - Vérifiez que le port est ouvert
   - Ajoutez une règle Inbound si nécessaire

4. Firewall local :
```bash
   sudo ufw status
```

## Commandes Utiles

### Docker
```bash
# Voir tous les containers
docker ps -a

# Voir les logs
docker logs -f <container_name>

# Redémarrer un container
docker restart <container_name>

# Entrer dans un container
docker exec -it <container_name> bash

# Voir l'utilisation des ressources
docker stats

# Nettoyer
docker system prune -a
```

### Kubernetes
```bash
# Voir les pods
kubectl get pods -A

# Logs d'un pod
kubectl logs <pod_name> -n <namespace>

# Décrire un pod
kubectl describe pod <pod_name> -n <namespace>

# Redémarrer un deployment
kubectl rollout restart deployment/<name> -n <namespace>
```

### Monitoring
```bash
# Voir les métriques Prometheus
curl http://localhost:9090/api/v1/targets

# Redémarrer le monitoring stack
cd monitoring
docker-compose restart
```

## Obtenir de l'Aide

Si vous rencontrez un problème non listé ici :

1. Vérifiez les logs du service concerné
2. Consultez la documentation officielle
3. Ouvrez une issue sur GitHub

## Réinitialisation Complète

**⚠️ Attention : Ceci supprimera TOUTES les données**
```bash
cd scripts
./cleanup.sh

# Puis réinstaller
./install-all.sh
./deploy.sh
```

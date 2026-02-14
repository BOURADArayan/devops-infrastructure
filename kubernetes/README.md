# Kubernetes Manifests

Manifestes Kubernetes pour déployer l'application DevOps Demo.

## Déploiement
```bash
# Créer le namespace
kubectl apply -f namespace.yaml

# Déployer l'application
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f configmap.yaml
kubectl apply -f ingress.yaml

# Ou avec Kustomize
kubectl apply -k .
```

## Vérification
```bash
kubectl get pods -n devops-app
kubectl get svc -n devops-app
kubectl logs -f deployment/devops-demo-app -n devops-app
```

## Accès
```bash
# Via NodePort
curl http://localhost:30100

# Via Ingress (ajouter dans /etc/hosts)
echo "127.0.0.1 devops-demo.local" | sudo tee -a /etc/hosts
curl http://devops-demo.local
```

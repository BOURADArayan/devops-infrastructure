# Guide de Contribution

Merci de votre intérêt pour contribuer à ce projet ! 🎉

## Comment Contribuer

### Signaler un Bug

1. Vérifiez que le bug n'a pas déjà été signalé dans les [Issues](https://github.com/VOTRE-USERNAME/devops-infrastructure/issues)
2. Créez une nouvelle issue avec le label `bug`
3. Décrivez le problème en détail :
   - Étapes pour reproduire
   - Comportement attendu
   - Comportement actuel
   - Logs ou captures d'écran

### Proposer une Fonctionnalité

1. Créez une issue avec le label `enhancement`
2. Décrivez la fonctionnalité et son utilité
3. Attendez les retours avant de commencer le développement

### Pull Requests

1. **Fork** le projet
2. **Créez une branche** pour votre feature :
```bash
   git checkout -b feature/ma-super-feature
```
3. **Committez** vos changements :
```bash
   git commit -m 'feat: ajout de ma super feature'
```
4. **Pushez** vers votre fork :
```bash
   git push origin feature/ma-super-feature
```
5. **Ouvrez une Pull Request**

### Standards de Code

- Utilisez des noms de variables explicites
- Commentez le code complexe
- Suivez la structure de dossiers existante
- Testez vos modifications avant de soumettre

### Convention de Commit

Utilisez [Conventional Commits](https://www.conventionalcommits.org/) :

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation
- `style:` Formatage
- `refactor:` Refactoring
- `test:` Tests
- `chore:` Tâches de maintenance

### Tests

Avant de soumettre :
```bash
# Tester le déploiement
./scripts/deploy.sh

# Vérifier que tous les services démarrent
docker-compose up -d
docker ps

# Vérifier Kubernetes
kubectl get pods -A
```

## Code de Conduite

Soyez respectueux et constructif dans vos interactions.

## Questions ?

N'hésitez pas à ouvrir une issue avec le label `question`.

Merci pour vos contributions ! 🙏

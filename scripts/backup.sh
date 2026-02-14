#!/bin/bash

BACKUP_DIR="$HOME/devops-backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="$BACKUP_DIR/backup_$TIMESTAMP"

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║          Backup de l'Infrastructure DevOps               ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

mkdir -p "$BACKUP_PATH"

echo "1️⃣  Backup des volumes Docker..."
for volume in jenkins_home portainer_data sonarqube_data prometheus-data grafana-data; do
    if docker volume inspect $volume >/dev/null 2>&1; then
        echo "  Backup de $volume..."
        docker run --rm -v $volume:/data -v $BACKUP_PATH:/backup alpine \
            tar czf /backup/$volume.tar.gz -C /data .
        echo "  ✅ $volume sauvegardé"
    fi
done

echo ""
echo "2️⃣  Backup des configurations..."
cp -r ~/devops-infrastructure "$BACKUP_PATH/"
echo "  ✅ Configurations sauvegardées"

echo ""
echo "3️⃣  Création de l'archive finale..."
cd "$BACKUP_DIR"
tar czf "backup_$TIMESTAMP.tar.gz" "backup_$TIMESTAMP"
rm -rf "backup_$TIMESTAMP"

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "✅ Backup terminé : $BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
echo "Taille: $(du -h $BACKUP_DIR/backup_$TIMESTAMP.tar.gz | cut -f1)"
echo "═══════════════════════════════════════════════════════════"

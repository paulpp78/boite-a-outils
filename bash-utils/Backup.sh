#!/bin/bash

BACKUP_DIR="$HOME/backups"
BACKUP_FILE="backup_$(date +'%Y-%m-%d').tar.gz"
FOLDER_TO_BACKUP="/chemin/vers/dossier"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Erreur: le répertoire de sauvegarde $BACKUP_DIR n'existe pas." >&2
  exit 1
fi

tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$FOLDER_TO_BACKUP"
if [ $? -ne 0 ]; then
  echo "Erreur: impossible de créer l'archive de sauvegarde." >&2
  exit 1
fi

MAX_BACKUPS=7
BACKUPS=$(ls -t "$BACKUP_DIR" | grep "^backup_" | tail -n +$MAX_BACKUPS)
if [ -n "$BACKUPS" ]; then
  echo "Suppression des sauvegardes antérieures: $BACKUPS"
  rm -f $BACKUP_DIR/$BACKUPS
fi

echo "Sauvegarde du dossier $FOLDER_TO_BACKUP dans le fichier $BACKUP_FILE"
echo "Taille de la sauvegarde: $(du -sh "$BACKUP_DIR/$BACKUP_FILE" | cut -f1)"

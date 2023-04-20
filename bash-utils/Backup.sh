#!/bin/bash

BACKUP_DIR="$HOME/backups"
BACKUP_FILE="backup_$(date +'%Y-%m-%d').tar.gz"
FOLDER_TO_BACKUP="/path/to/folder"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Error: backup directory $BACKUP_DIR does not exist." >&2
  exit 1
fi

tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$FOLDER_TO_BACKUP"
if [ $? -ne 0 ]; then
  echo "Error: could not create backup archive." >&2
  exit 1
fi

MAX_BACKUPS=7
BACKUPS=$(ls -t "$BACKUP_DIR" | grep "^backup_" | tail -n +$MAX_BACKUPS)
if [ -n "$BACKUPS" ]; then
  echo "Deleting old backups: $BACKUPS"
  rm -f $BACKUP_DIR/$BACKUPS
fi

echo "Backed up $FOLDER_TO_BACKUP to $BACKUP_FILE"
echo "Backup size: $(du -sh "$BACKUP_DIR/$BACKUP_FILE" | cut -f1)"
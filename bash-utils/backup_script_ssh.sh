#!/bin/bash

USER="utilisateur"
HOST="serveur_distant"
REMOTE_DIR="/chemin/vers/le/repertoire/destination"
FILES="/chemin/vers/les/fichiers/*"

tar czf backup.tar.gz $FILES

ssh $USER@$HOST "mkdir -p $REMOTE_DIR && scp $REMOTE_DIR/backup.tar.gz $REMOTE_DIR/backup.tar.gz.old && mv $REMOTE_DIR/backup.tar.gz $REMOTE_DIR/backup.tar.gz.old && cat $REMOTE_DIR/backup.tar.gz.old | gunzip -c | cat - backup.tar.gz | gzip > $REMOTE_DIR/backup.tar.gz && rm $REMOTE_DIR/backup.tar.gz.old"

scp backup.tar.gz $USER@$HOST:$REMOTE_DIR

rm backup.tar.gz

echo "Sauvegarde terminée"

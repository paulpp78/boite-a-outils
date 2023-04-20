#!/bin/bash

USER="user"
HOST="remote_server"
REMOTE_DIR="/path/to/destination/directory"
FILES="/path/to/files/*"

# Compress local files into backup.tar.gz
tar czf backup.tar.gz $FILES

# Transfer backup.tar.gz to remote server and update backup archive
ssh $USER@$HOST "
    mkdir -p $REMOTE_DIR && \
    mv $REMOTE_DIR/backup.tar.gz $REMOTE_DIR/backup.tar.gz.old && \
    cat $REMOTE_DIR/backup.tar.gz.old | gunzip -c | cat - backup.tar.gz | gzip > $REMOTE_DIR/backup.tar.gz && \
    rm $REMOTE_DIR/backup.tar.gz.old
" < backup.tar.gz

# Remove local backup.tar.gz
rm backup.tar.gz

echo "Backup completed"

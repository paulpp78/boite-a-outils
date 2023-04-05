#!/bin/bash

THRESHOLD=10
EMAIL="votre@email.com"

check_space() {
  SPACE_FREE=$(df -h | awk '/\/dev\/sda1/ {print $5}' | sed 's/%//')
  if [ "$SPACE_FREE" -lt "$THRESHOLD" ]; then
    echo "Attention : Espace disque faible sur le système $(hostname)" | mail -s "Alerte Espace disque faible" $EMAIL
  fi
}

while true; do
  check_space
  sleep 24h
done

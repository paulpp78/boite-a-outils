#!/bin/bash

THRESHOLD=10
EMAIL="your@email.com"

check_space() {
  SPACE_FREE=$(df -h | awk '/\/dev\/sda1/ {print $5}' | sed 's/%//')
  if [ "$SPACE_FREE" -lt "$THRESHOLD" ]; then
    echo "Warning: Low disk space on $(hostname) system" | mail -s "Low Disk Space Alert" $EMAIL
  fi
}

while true; do
  check_space
  sleep 24h
done

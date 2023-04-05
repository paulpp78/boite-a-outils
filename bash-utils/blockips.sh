#!/bin/bash

LOG_FILE="/var/log/auth.log"
THRESHOLD=10
blocked_ips=()

tail -n0 -f "$LOG_FILE" | while read LINE; do
  if echo "$LINE" | grep -q "Failed password"; then
    IP=$(echo "$LINE" | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}")
    if echo "${blocked_ips[@]}" | grep -q "$IP"; then
      continue
    fi
    COUNT=$(grep -c "$IP" "$LOG_FILE")
    if [ "$COUNT" -ge "$THRESHOLD" ]; then
      echo "Alerte de sécurité: l'adresse IP $IP a été bloquée pour tentative d'intrusion."
      iptables -A INPUT -s $IP -j DROP
      blocked_ips+=("$IP")
      echo "$(date) - $IP bloqué pour tentative d'intrusion." >> /var/log/security.log
    fi
  fi
done

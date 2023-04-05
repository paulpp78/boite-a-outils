#!/bin/bash

ALLOWED_IPS=("192.168.1.10" "192.168.1.11")
CONNECTIONS=$(netstat -tnp | awk '$4 ~ /:22$/ {print $5}' | cut -d: -f1 | sort | uniq)

for IP in $CONNECTIONS; do
    if [[ ! "${ALLOWED_IPS[@]}" =~ "${IP}" ]]; then
        echo "Connexion SSH suspecte depuis l'adresse IP ${IP}" | mail -s "Alerte SSH" admin@example.com
    fi
done

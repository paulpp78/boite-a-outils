#!/bin/bash

IP_LIST="192.168.1.1 192.168.1.2 192.168.1.3"
EMAIL_NOTIFICATION=true
EMAIL_ADDRESS="votre-adresse-email@gmail.com"
EMAIL_SUBJECT="Alerte sécurité: port ouvert détecté"
OUTPUT_FILE=$(mktemp)

for IP_ADDRESS in $IP_LIST; do
    nmap -T4 -Pn -sS -sU -p- $IP_ADDRESS -oN $OUTPUT_FILE > /dev/null 2>&1

    PORT_COUNT=$(grep -c "open " $OUTPUT_FILE)
    if [ $PORT_COUNT -eq 0 ]; then
        echo "Aucun port ouvert n'a été détecté sur l'adresse IP $IP_ADDRESS."
    else
        echo "Ports ouverts détectés sur l'adresse IP $IP_ADDRESS:"
        grep "open " $OUTPUT_FILE
        if [ "$EMAIL_NOTIFICATION" = true ]; then
            echo "Envoi d'un e-mail d'alerte à l'adresse $EMAIL_ADDRESS..."
            mail -s "$EMAIL_SUBJECT" "$EMAIL_ADDRESS" < $OUTPUT_FILE
        fi
    fi
done

rm $OUTPUT_FILE

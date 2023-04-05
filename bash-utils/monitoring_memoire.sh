#!/bin/bash

threshold=20
user_email="utilisateur@example.com"

free_mem=$(free | awk '/^Mem:/{printf "%.0f\n", $4/$2 * 100}')

if [[ $free_mem -lt $threshold ]]; then
    echo "Attention : la mémoire disponible est de $free_mem%. Utilisation excessive de la mémoire" | mail -s "Alerte mémoire" $user_email
fi

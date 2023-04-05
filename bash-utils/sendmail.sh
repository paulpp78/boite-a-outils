#!/bin/bash

# Vérifie les arguments en entrée
if [[ $# -lt 5 ]]; then
    echo "Usage: $0 [from] [to] [subject] [message_file] [attachment_file]"
    exit 1
fi

# Définir les variables
from="$1"
to="$2"
subject="$3"
message_file="$4"
attachment_file="$5"

# Vérifie que les fichiers existent
for file in "$message_file" "$attachment_file"; do
    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' not found"
        exit 1
    fi
done

# Envoie l'email
/usr/sbin/sendmail -F "$from" -t <<EOF
To: $to
Subject: $subject
Content-Type: multipart/mixed; boundary=$(date +%s)

--$(date +%s)
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

$(cat "$message_file")

--$(date +%s)
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=$(basename "$attachment_file")
Content-Transfer-Encoding: base64

$(base64 -w 0 "$attachment_file")

--$(date +%s)--
EOF

echo "Email sent from '$from' to '$to' with subject '$subject' and attachment '$attachment_file'"

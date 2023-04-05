#!/bin/bash

# Configuration des paramètres de sécurité des mots de passe
PASSWORD_LENGTH=15
PASSWORD_COMPLEXITY=4
PASSWORD_EXPIRATION=90
PASSWORD_FILE="passwords.txt"

# Vérification de l'existence du fichier de mots de passe
if [ ! -f $PASSWORD_FILE ]; then
    echo "Le fichier de mots de passe n'existe pas. Il va être créé."
    touch $PASSWORD_FILE
    chmod 600 $PASSWORD_FILE
fi

# Fonction de génération de mot de passe aléatoire
generate_password() {
    while true; do
        password=$(tr -dc '[:graph:]' < /dev/urandom | head -c $PASSWORD_LENGTH)
        if [[ "$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [[:digit:]] && "$password" =~ [^[:alnum:]] ]]; then
            echo "$password"
            break
        fi
    done
}

# Fonction de vérification de la complexité du mot de passe
check_password_complexity() {
    local password="$1"
    local score=0

    # Vérification de la présence de caractères spéciaux
    if [[ $password =~ [^A-Za-z0-9_]+ ]]; then
        ((score+=1))
    fi

    # Vérification de la présence de chiffres
    if [[ $password =~ [0-9]+ ]]; then
        ((score+=1))
    fi

    # Vérification de la présence de lettres majuscules et minuscules
    if [[ $password =~ [A-Z]+ ]]; then
        ((score+=1))
    fi
    if [[ $password =~ [a-z]+ ]]; then
        ((score+=1))
    fi

    echo $score
}

# Fonction de vérification de l'expiration du mot de passe
check_password_expiration() {
    local timestamp=$(date +%s)
    local file_timestamp=$(stat -c %Y $PASSWORD_FILE)
    local difference=$((($timestamp - $file_timestamp) / 86400))

    if [ $difference -ge $PASSWORD_EXPIRATION ]; then
        echo "true"
    else
        echo "false"
    fi
}

# Menu principal
while true; do
    clear
    echo -e "\e[38;5;226m     _____ _                 ____                           _                     \e[0m"
    echo -e "\e[38;5;226m    |_   _| |__   ___       / ___| ___ _ __   ___ _ __ __ _| |_ ___  _ __         \e[0m"
    echo -e "\e[38;5;226m      | | | '_ \ / _ \_____| |  _ / _ \ '_ \ / _ \ '__/ _  | __/ _ \| '__|        \e[0m"
    echo -e "\e[38;5;226m      | | | | | |  __/_____| |_| |  __/ | | |  __/ | | (_| | || (_) | |           \e[0m"
    echo -e "\e[38;5;226m      |_| |_| |_|\___|      \____|\___|_| |_|\___|_|  \__,_|\__\___/|_|           \e[0m"
    echo ""
    echo -e "\e[38;5;226m1. \e[0mGénérer un nouveau mot de passe"
    echo -e "\e[38;5;226m2. \e[0mAfficher les mots de passe stockés"
    echo -e "\e[38;5;226m3. \e[0mVérifier la complexité des mots de passe"
    echo -e "\e[38;5;226m4. \e[0mVérifier l'expiration des mots de passe"
    echo -e "\e[38;5;226m5. \e[0mQuitter"
    echo ""
    read -p "$(echo -e "\e[38;5;226mEntrez votre choix : \e[0m")" choice



    case $choice in
        1)
            echo "Génération d'un nouveau mot de passe..."
            password=$(generate_password)
            echo "Le nouveau mot de passe est : $password"
            read -p "Entrez le nom du service associé au mot de passe : " service
            echo "$service:$password" >> $PASSWORD_FILE
            ;;
        2)
            echo "Affichage des mots de passe stockés :"
            cat $PASSWORD_FILE
            sleep 2
            ;;
        3)
            echo "Vérification de la complexité des mots de passe..."
            while read -r line; do
                service=$(echo $line | cut -d':' -f1)
                password=$(echo $line | cut -d':' -f2)
                score=$(check_password_complexity $password)
                if [ $score -lt $PASSWORD_COMPLEXITY ]; then
                    echo "Le mot de passe pour le service $service est trop faible (score=$score)."
                fi
            done < $PASSWORD_FILE
            sleep 2
            ;;
          4)

            echo "Vérification de l'expiration des mots de passe..."
            password_expired=$(check_password_expiration)
            if [ "$password_expired" = "true" ]; then
                echo "Le fichier de mots de passe a expiré. Tous les mots de passe doivent être mis à jour."
            else
                echo "Le fichier de mots de passe est à jour. Les mots de passe sont valides pour encore $((PASSWORD_EXPIRATION - difference)) jours."
            fi
            read -n1 -r -p "Appuyez sur une touche pour continuer..."
            ;;

          5)

            echo "Au revoir !"
            exit 0
            ;;
    esac
done
#!/bin/bash

echo "Script de renommage de fichiers"

read -p "Entrez le chemin absolu du répertoire : " directory
read -p "Entrez le préfixe à ajouter aux noms de fichiers : " prefix

cd "$directory" || { echo "Erreur : le répertoire $directory n'existe pas" ; exit 1 ; }

for file in *
do
    if [ -f "$file" ]
    then
        mv "$file" "${prefix}${file}" && echo "Le fichier $file a été renommé en ${prefix}${file}"
    fi
done

echo "Le renommage des fichiers dans le répertoire $directory est terminé."

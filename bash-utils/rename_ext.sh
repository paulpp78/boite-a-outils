#!/bin/bash
read -p "Répertoire contenant les fichiers à renommer : " dir_path
read -p "Extension des fichiers à renommer : " file_ext
read -p "Nouvelle extension : " new_ext
cd "$dir_path"
for file in *."$file_ext"; do
    mv -- "$file" "${file%.$file_ext}.$new_ext"
done
echo "Les fichiers avec l'extension $file_ext ont été renommés avec succès."
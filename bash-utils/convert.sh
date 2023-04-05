#!/bin/bash

DIR="/chemin/vers/le/repertoire"

for file in "$DIR"/*.{docx,pdf,md,html}; do
    if [ -f "$file" ]; then
        extension="${file##*.}"
        filename="${file%.*}"
        case $extension in
            docx)
                libreoffice --headless --convert-to pdf --outdir "$DIR" "$file" && \
                mv "$DIR/$filename.pdf" "$DIR/$filename".pdf ;;
            pdf)
                libreoffice --headless --convert-to docx --outdir "$DIR" "$file" && \
                mv "$DIR/$filename.docx" "$DIR/$filename".docx ;;
            md)
                pandoc "$file" -f markdown -t html -s -o "$DIR/${filename}.html" ;;
            html)
                pandoc "$file" -f html -t markdown -s -o "$DIR/${filename}.md" ;;
            *)
                echo "Format de fichier non supporté : $file" ;;
        esac
    fi
done

echo "Conversion terminée"
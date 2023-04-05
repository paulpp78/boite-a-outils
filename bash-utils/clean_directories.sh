#!/bin/bash

clean_dirs=("/var/log" "/tmp")

for dir in "${clean_dirs[@]}"; do
  find "$dir" -type f -mtime +30 -delete
done

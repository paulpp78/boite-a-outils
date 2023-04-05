#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install -y git curl wget build-essential
sudo apt clean
sudo apt autoremove -y
echo "Mise à jour et installation des paquets terminées avec succès."

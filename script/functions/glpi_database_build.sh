#!/bin/bash

# build DATABASE container
echo "[+] Building DATABASE container..."
echo "    Please wait..."
if docker pull alpine:3.17 >>/var/log/docker_glpi 2>&1; then
    docker build -t glpi-mariadb "$pwd"/config/mariadb/ >>/var/log/docker_glpi 2>&1
    echo "[i] Build DATABASE container done!"
else
    echo "[W] Something went wrong while building the docker DATABASE image"
    echo "    Look /var/log/docker_glpi for more details"
fi

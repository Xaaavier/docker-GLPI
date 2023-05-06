#!/bin/bash

# build REDIS container
echo "[+] Building REDIS container..."
echo "    Please wait..."
if docker pull redis:alpine3.17 >>/var/log/docker_glpi 2>&1; then
    docker build -t glpi-redis "$pwd"/config/redis/ >>/var/log/docker_glpi 2>&1
    echo "[i] Build REDIS container done!"
else
    echo "[W] Something went wrong while building the docker REDIS image"
    echo "    Look /var/log/docker_glpi for more details"
fi

#!/bin/bash

# build PHP container
echo "[+] Building PHP container..."
echo "    Please wait..."
if docker pull php:fpm-alpine3.17 >>/var/log/docker_glpi 2>&1; then
    docker build -t glpi-php "$pwd"/config/php/ >>/var/log/docker_glpi 2>&1
    echo "[i] Build PHP container done!"
else
    echo "[W] Something went wrong while building the docker PHP image"
    echo "    Look /var/log/docker_glpi for more details"
fi

#!/bin/bash

# build DATABASE container
echo "[+] Building WEBSERVER container..."
echo "    Please wait..."
if docker pull nginx:stable-alpine3.17 >>/var/log/docker_glpi 2>&1; then
    docker build -t glpi-nginx "$pwd"/config/nginx/ >>/var/log/docker_glpi 2>&1
    echo "[i] Build WEBSERVER container done!"
else
    echo "[W] Something went wrong while building the docker WEBSERVER image"
    echo "    Look /var/log/docker_glpi for more details"
fi

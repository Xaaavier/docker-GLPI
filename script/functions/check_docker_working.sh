#!/bin/bash

# Check that the Docker daemon is working and create containers
if docker run hello-world >>/var/log/docker_glpi 2>&1; then
    docker image rm hello-world -f >>/var/log/docker_glpi
    docker container prune -f
    echo "[I] Docker's daemon working proprietly..."
else
    echo "[W] Something went wrong whith Docker's daemon..."
    echo "    Look /var/log/docker_glpi for more details"
fi

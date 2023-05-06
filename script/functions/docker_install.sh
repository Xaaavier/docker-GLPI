#!/bin/bash
{
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
} >>/var/log/docker_glpi 2>&1
echo "[i] Docker daemon installation done !"

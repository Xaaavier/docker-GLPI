#!/bin/bash

# Check distribution's name
if ! [[ "$(lsb_release -i | cut -f 2)" =~ ^(Debian|Ubuntu)$ ]]; then
    echo "[W] Unsupported distribution..."
    exit 1
else
    # Check distribution's version
    if ! [[ "$(lsb_release -cs)" =~ ^(bionic|focal|jammy|kinetic|bullseye|buster)$ ]]; then
        echo "[W] Unsupported version..."
        exit 1
    else
        # Check Docker install
        if ! [ -x "$(command -v docker)" ]; then
            echo "[i] Docker is not installed !"
            echo "    Loading installation..."
            # Set up Docker's repository and install Docker
            if [ "$(lsb_release -i | cut -f 2)" == "Debian" ]; then
                apt-get update >>/var/log/docker_glpi 2>&1
                echo "    Update done !"
                apt-get install -y ca-certificates curl gnupg >>/var/log/docker_glpi 2>&1
                echo "    Dependances installation done !"
                {
                    install -m 0755 -d /etc/apt/keyrings
                    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                    chmod a+r /etc/apt/keyrings/docker.gpg
                    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
                } >>/var/log/docker_glpi 2>&1
                echo "[i] Docker repo installation done !"
            elif [ "$(lsb_release -i | cut -f 2)" == "Ubuntu" ]; then
                apt-get update >>/var/log/docker_glpi 2>&1
                echo "[i] Update done"
                apt-get install -y ca-certificates curl gnupg >>/var/log/docker_glpi 2>&1
                echo "[i] Dependances installation done !"
                {
                    install -m 0755 -d /etc/apt/keyrings
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                    chmod a+r /etc/apt/keyrings/docker.gpg
                    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
                } >>/var/log/docker_glpi 2>&1
                echo "[i] Docker repo installation done !"
            fi
        fi
    fi
fi

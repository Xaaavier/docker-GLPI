#!/bin/bash
cp -r /srv/www/glpi/update/ /srv/www/glpi/update.old/
function update() {
echo "What is the download link for the latest GLPI version? (tar.gz format archive)"
read -r URL_UPDATE
wget -P /tmp/ "$URL_UPDATE"
FILENAME=$(basename "$URL_UPDATE")
tar -xvzf /tmp/"$FILENAME" -C /tmp/
cp -r /tmp/glpi/* /srv/www/glpi/update/
#cp "$pwd"/config/glpi/downstream.php /srv/www/glpi/update/inc/
rm -rf /srv/www/glpi/update/config/
rm -rf /srv/www/glpi/update/files/
}
# build update
echo "[+] Building update..."
echo "    Please wait..."
if cd "$pwd"/ && docker-compose down; then
    if update >>/var/log/docker_glpi 2>&1; then
        if cd "$pwd"/ && docker-compose up -d >>/var/log/docker_glpi 2>&1; then
            echo "Perform GLPI update then press a key to continue..."
            read -rsn1
            rm -rf /srv/www/glpi/update/install/ >>/var/log/docker_glpi 2>&1
            echo "[I] Update done !"
        else
            echo "[W] Something went wrong while updating GLPI"
            echo "    Look /var/log/docker_glpi for more details"
        fi
    else
        echo "[W] Something went wrong while updating GLPI"
        echo "    Look /var/log/docker_glpi for more details"
    fi
else
    echo "[W] Something went wrong while updating GLPI"
    echo "    Look /var/log/docker_glpi for more details"
fi

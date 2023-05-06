#!/bin/bash
# Generate passwords for database container
MYSQL_ROOT_PWD=$(tr -dc "[:alnum:]" </dev/urandom | fold -w 20 | head -n 1)
MYSQL_USER_PWD=$(tr -dc "[:alnum:]" </dev/urandom | fold -w 20 | head -n 1)

function web_environment() {
    wget -P /tmp/ "$URL_UPDATE"
    FILENAME=$(basename "$URL_UPDATE")
    tar -xvzf /tmp/"$FILENAME" -C /tmp/
    mkdir -p /srv/www/glpi/update/
    mkdir -p /srv/www/glpi/noupdate/
    cp -r /tmp/glpi/* /srv/www/glpi/update/
    cp -r /tmp/glpi/config/ /srv/www/glpi/noupdate/
    cp -r /tmp/glpi/files/ /srv/www/glpi/noupdate/
    cp "$pwd"/config/glpi/downstream.php /srv/www/glpi/update/inc/
    rm -rf /srv/www/glpi/update/config/
    rm -rf /srv/www/glpi/update/files/
    chmod -R o+rw /srv/www/glpi/
    chmod -R o+rw /var/log/glpi/
}
# build WEB container
echo "[+] Building WEB container..."
echo "[?] What is the download link for the latest GLPI version? (tar.gz format archive)"
read -r URL_UPDATE
echo "    Please wait..."
# Setting up WEB environment
if web_environment >>/var/log/docker_glpi 2>&1; then
    echo "[+] Setting up WEB environment done!"
    echo "What will be the database name ?"
    read -r DATABASENAME
    echo "What will be the database username ?"
    read -r USERNAME
    sed -i 's/MYSQL_ROOT_PWD/'"$MYSQL_ROOT_PWD"'/g' "$pwd"/docker-compose.yml
    sed -i 's/DATABASENAME/'"$DATABASENAME"'/g' "$pwd"/docker-compose.yml
    sed -i 's/USERNAME/'"$USERNAME"'/g' "$pwd"/docker-compose.yml
    sed -i 's/MYSQL_USER_PWD/'"$MYSQL_USER_PWD"'/g' "$pwd"/docker-compose.yml
    if cd "$pwd"/ && docker-compose up -d >>/var/log/docker_glpi 2>&1; then
        echo "[+] Setting up GLPI done!"
        echo "    Please  go to \"http://127.0.0.1\" and launch database initialisation"
        echo "    Remember :"
        echo "       - database root pwd   =   $MYSQL_ROOT_PWD"
        echo "       - database name       =   $DATABASENAME"
        echo "       - database user       =   $USERNAME"
        echo "       - database user pwd   =   $MYSQL_USER_PWD"
        echo "       - database IP address =   10.5.0.3"
        echo ""
        echo "[I] Keep this informtation preciously and secret !"
        echo "Perform GLPI initialization then press a key to continue..."
        read -rsn1
        docker exec "$(docker ps --filter name="glpi-databaseserver" --format "{{.ID}}")" sh -c 'mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot -p"'"$MYSQL_ROOT_PWD"'" --socket=/var/run/mysqld/mysqld.sock mysql'
        docker exec "$(docker ps --filter name="glpi-databaseserver" --format "{{.ID}}")" mysql -uroot -p"$MYSQL_ROOT_PWD" -e "GRANT SELECT ON mysql.time_zone_name TO '$USERNAME'@'10.5.0.2'; FLUSH PRIVILEGES;"
        docker restart "$(docker ps --filter name="glpi-databaseserver" --format "{{.ID}}")"
        sleep 5
        docker exec "$(docker ps --filter name=glpi-phpserver --format "{{.ID}}")" php /var/www/html/glpi/bin/console database:enable_timezones
        docker exec "$(docker ps --filter name=glpi-phpserver --format "{{.ID}}")" php /var/www/html/glpi/bin/console cache:configure --context core --dsn redis://10.5.0.4:6379
        rm -rf /srv/www/glpi/update/install/ >>/var/log/docker_glpi 2>&1
        if cd "$pwd"/ && docker-compose down >>/var/log/docker_glpi 2>&1; then
            sed -i "/MYSQL_/d" docker-compose.yml
            cd "$pwd"/ && docker-compose up -d
        fi
        echo "[I] Installation done !"
    else
        echo "[W] Something went wrong while building WEB environment"
        echo "    Look /var/log/docker_glpi for more details"
    fi
else
    echo "[W] Something went wrong while building WEB environment"
    echo "    Look /var/log/docker_glpi for more details"
fi

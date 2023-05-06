#!/bin/bash

chmod +x "$pwd"/script/functions/*.sh
if "$pwd"/script/functions/docker_checks.sh; then
    if "$pwd"/script/functions/docker_install.sh; then
        if "$pwd"/script/functions/check_docker_working.sh; then
            if "$pwd"/script/functions/glpi_database_build.sh; then
                if "$pwd"/script/functions/glpi_redis_build.sh; then
                    if "$pwd"/script/functions/glpi_php_build.sh; then
                        if "$pwd"/script/functions/glpi_web_build.sh; then
                            if "$pwd"/script/functions/glpi_install.sh; then
                                exit 0
                            else
                                exit 1
                            fi
                        else
                            exit 1
                        fi
                    else
                        exit 0
                    fi
                else
                    exit 0
                fi
            else
                exit 0
            fi
        else
            exit 0
        fi
    else
        exit 0
    fi
else
    exit 0
fi

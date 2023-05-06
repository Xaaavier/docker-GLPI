#!/bin/bash
#############################
#         Variables         #
#############################
opt=$1
pwd=$(pwd)
#############################
#          Warnings         #
#############################
## We check the rights with which the script is launched
if [[ $EUID -ne 0 ]]; then
    echo "This script MUST be run with super user privileges!"
    echo "Relunch this script like this \"sudo ./glpi.sh\" or as root (inadvisable)"
    exit
else
    # Appears only if the script is launched without arguments
    if [ $# -eq 0 ]; then
        clear
        chmod +x "$pwd"/script/resume.sh
        "$pwd"/script/resume.sh
        exit 0
    fi
    #############################
    #          Options          #
    #############################
    # Setting possible options for the script
    eval set -- "$opt"
    while true; do
        case "$1" in
        --help)
            clear
            chmod +x "$pwd"/script/help.sh
            export pwd
            "$pwd"/script/help.sh
            exit 0
            ;;
        --install)
            clear
            chmod +x "$pwd"/script/install.sh
            export pwd
            echo "[i] GLPI Docker install start now.."
            "$pwd"/script/install.sh
            exit 0
            ;;
        --update)
            clear
            chmod +x "$pwd"/script/functions/glpi_update.sh
            export pwd
            echo "[i] GLPI Docker update start now.."
            "$pwd"/script/update.sh
            exit 0
            ;;
        --*)
            echo "Option not recognized, run the script with the \"--help\" option to see the help"
            exit 0
            ;;
        esac
    done
    exit 0
fi

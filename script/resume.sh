#!/bin/bash
echo -e "######################################################################################
##                            INSTALLATION & UPDATE GLPI                            ##
######################################################################################
##                                                                                  ##
##  The purpose of this utility is to automate the installation and update of       ##
##  GLPI.                                                                           ##
##                                                                                  ##
##  This tool is designed to set up a Docker environment consisting of a WEB        ##
##  container (nginx), a PHP container (php-fpm) and a DATABASE container           ##
##  (mariadb).                                                                      ##
##                                                                                  ##
##  The WEB container is the docker image : nginx:stable-alpine3.17                 ##
##  The PHP container is based on the \"php:fpm-alpine3.17\" docker image.            ##
##  The DATABASE container is based on the \"alpine3.17\" docker image :              ##
##    and on yobasystems's work.                                                    ##
##                                                                                  ##
######################################################################################"
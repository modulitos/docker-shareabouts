#!/bin/bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`

# variables defined from now on to be automatically exported:
set -a
source .env

# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
NGINX_VARS='$FLAVOR_1:$FLAVOR_1_PORT:$FLAVOR_1_DOMAIN:$FLAVOR_2:$FLAVOR_2_PORT:$FLAVOR_2_DOMAIN:$FLAVOR_3:$FLAVOR_3_PORT:$FLAVOR_3_DOMAIN:$MY_DOMAIN_NAME:$DOMAINS'
envsubst "$NGINX_VARS" < nginx.conf > nginx-envsubst.conf

envsubst "$NGINX_VARS" < nginx-acme-challenge.conf > nginx-acme-challenge-envsubst.conf

cat compose.yml | envsubst | docker-compose -f - -p ${PROJECT_NAME} up -d

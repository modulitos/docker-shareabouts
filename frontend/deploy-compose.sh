#!/bin/bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`

# variables defined from now on to be automatically exported:
set -a
source .env

# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
MYVARS='$FLAVOR_1:$FLAVOR_1_PORT:$FLAVOR_2:$FLAVOR_2_PORT:$FLAVOR_3:$FLAVOR_3_PORT:$FLAVOR_1_DOMAIN:$FLAVOR_2_DOMAIN:$FLAVOR_3_DOMAIN'
envsubst "$MYVARS" < nginx.conf > nginx-envsubst.conf

cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p ${PROJECT_NAME} up -d

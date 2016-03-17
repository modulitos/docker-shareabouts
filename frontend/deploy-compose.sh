#!/bin/bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`
source .env

# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
MYVARS='$FLAVOR_1:$FLAVOR_1_PORT:$FLAVOR_2:$FLAVOR_2_PORT:$FLAVOR_3:$FLAVOR_3_PORT'
envsubst "$MYVARS" < nginx.conf > nginx-envsubst.conf

export $(grep "^[^#]" .env | xargs) && cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p ${PROJECT_NAME} up -d

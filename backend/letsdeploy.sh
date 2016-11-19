#!/bin/bash

docker rm -f `docker ps -aq -f name=${DEPLOYMENT_TYPE}_*`

# variables defined from now on to be automatically exported:
set -a
source .env

if [[ $DEPLOYMENT_TYPE == 'production' ]]; then
    # To avoid substituting nginx-related variables, lets specify only the
    # variables that we will substitute with envsubst:
    NGINX_VARS='$DOMAINS:$MY_DOMAIN_NAME'
    envsubst "$NGINX_VARS" < nginx.conf > nginx-envsubst.conf

    envsubst "$NGINX_VARS" < nginx-acme-challenge.conf > nginx-acme-challenge-envsubst.conf
fi

# We have the compose project (COMPOSE_PROJECT_NAME) and the deployment share the same name
docker-compose -p ${DEPLOYMENT_TYPE} -f ${DEPLOYMENT_TYPE}.yml up -d

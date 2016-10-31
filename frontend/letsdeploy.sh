#!/bin/bash

docker rm -f `docker ps -aq -f name=${COMPOSE_PROJECT_NAME}_*`

# variables defined from now on to be automatically exported:
set -a
source .env

# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
NGINX_VARS='$MY_DOMAIN_NAME:$DOMAINS'
envsubst "$NGINX_VARS" < pod0.conf > pod0-envsubst.conf
envsubst "$NGINX_VARS" < pod1.conf > pod1-envsubst.conf

# For SSL:
envsubst "$NGINX_VARS" < nginx-acme-challenge.conf > nginx-acme-challenge-envsubst.conf

# docker-compose -f pod0.yml up -d
docker-compose -f pod1.yml up -d

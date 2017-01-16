#!/bin/bash

echo "killing all project containers:"
docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`

# variables defined from now on to be automatically exported:
set -a
source .env

# If no args, just kill the containers.
if [[ -z $1 ]]
then
  exit 0
fi

echo "starting project containers:"
# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
NGINX_VARS='$MY_DOMAIN_NAME:$DOMAINS'
envsubst "$NGINX_VARS" < ${1}.conf > ${1}-envsubst.conf

# For SSL:
envsubst "$NGINX_VARS" < nginx-acme-challenge.conf > nginx-acme-challenge-envsubst.conf

docker-compose -f ${1}.yml up -d

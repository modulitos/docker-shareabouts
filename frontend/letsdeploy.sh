#!/bin/bash

echo "killing all project containers:"
docker rm -f `docker ps -aq -f name=${PROJECT}_*`

# variables defined from now on to be automatically exported:
set -a
source .env

# If no args, just kill the containers.
if [[ -z $PROJECT ]]
then
  echo "No PROJECT defined, exiting..."
  exit 0
fi

echo "starting project containers for ${PROJECT}:"
# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
NGINX_VARS='$MY_DOMAIN_NAME:$DOMAINS'
envsubst "$NGINX_VARS" < ${PROJECT}.conf > ${PROJECT}-envsubst.conf

# For SSL:
envsubst "$NGINX_VARS" < nginx-acme-challenge.conf > nginx-acme-challenge-envsubst.conf

docker-compose -p ${PROJECT} -f ${PROJECT}.yml up -d

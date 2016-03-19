#!/bin/bash

docker rm -f `docker ps -aq -f name=backend_*`

# variables defined from now on to be automatically exported:
set -a
source .env

# To avoid substituting nginx-related variables, lets specify only the
# variables that we will substitute with envsubst:
NGINX_VARS='$DOMAINS'
envsubst "$NGINX_VARS" < nginx.conf > nginx-envsubst.conf

docker-compose -f compose.yml -p backend_ up -d

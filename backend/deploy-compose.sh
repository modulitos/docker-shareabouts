#!/bin/bash

docker rm -f `docker ps -aq -f name=backend_*`
source .env
export $(grep "^[^#]" .env | xargs) && cat backups-api-nginx_compose.yml | envsubst | docker-compose -f - -p backend_ up -d

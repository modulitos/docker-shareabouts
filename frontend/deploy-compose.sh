#!/bin/bash

docker rm -f `docker ps -aq -f name=${PROJECT_NAME}_*`
# docker rm -f `docker ps -aq -f name=frontend_*`
source .env
export $(cat .env | grep ^[^#] | xargs) && cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p ${PROJECT_NAME} up -d

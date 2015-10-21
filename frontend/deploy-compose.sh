#!/bin/bash

# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
docker rm -f `docker ps -aq`
source .env
export $(cat .env | grep ^[^#] | xargs) && cat ${COMPOSE_CONFIG} | envsubst | docker-compose -f - -p "frontend" up -d

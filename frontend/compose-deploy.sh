#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
source .env
# echo "FLAVOR: ${FLAVOR}"
# echo "DEBUG: ${DEBUG}"
docker-compose -f compose.yml -p app up -d

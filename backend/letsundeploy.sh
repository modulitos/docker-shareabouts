#!/bin/bash

# variables defined from now on to be automatically exported:
set -a
source .env

docker-compose -p ${DEPLOYMENT_TYPE} -f ${DEPLOYMENT_TYPE}.yml stop

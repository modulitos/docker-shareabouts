#!/bin/bash

source .env
./docker-deploy-nginx.sh smartercleanup/flavors-nginx ${FLAVOR} nginx-${FLAVOR}

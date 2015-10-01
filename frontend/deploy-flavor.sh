#!/bin/bash

source .env
./docker-deploy-flavors.sh smartercleanup/flavor ${FLAVOR}

#!/bin/bash

# assumes that we have a "raingardens" container already deployed
DOCKER_REPO="$1"
echo "Docker repo: $DOCKER_REPO"


if [[ "$1" != "lukeswart/duwamish-nginx-flavors" ]]; then
    echo "killing container:"
    docker kill nginx
    echo "removing container:"
    docker rm nginx

    docker run -d \
           --name "nginx" \
           --volumes-from duwamish_flavor \
           --link duwamish_flavor:duwamish_flavor \
           -p 80:80 \
           -p 443:443 \
           -it $DOCKER_REPO

#           -p 9090:9090 \
#           --link duwamish_flavor:duwamish_flavor \
#           --link geoserver:geoserver \
           # -it lukeswart/duwamish-nginx
else # "lukeswart/duwamish-nginx-flavors"
    echo "killing container:"
    docker kill nginx-flavors
    echo "removing container:"
    docker rm nginx-flavors

    docker run -d \
           --name "nginx-flavors" \
           --volumes-from raingardens \
           --link raingardens:raingardens \
           --link demo1:demo1 \
           --link demo2:demo2 \
           -p 80:80 \
           -it $DOCKER_REPO

fi

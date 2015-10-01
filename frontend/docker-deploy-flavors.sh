#!/bin/bash

DOCKER_REPO="$1"
echo "docker repo is $DOCKER_REPO"

if [[ "$2" != "" ]]; then
    FLAVOR="$2"
else
    FLAVOR="duwamish_flavor"
fi

echo "selected FLAVOR is $FLAVOR"

flavors=(marra happytrail raingardens duwamish_flavor)

PORT=-1
for (( i = 0; i < ${#flavors[@]}; i++ )); do
    if [ "${flavors[$i]}" = "$FLAVOR" ]; then
        PORT=$((8005+$i));
        break
    fi
done

if [[ "${PORT}" = -1 ]]; then
    echo "No matches for your flavor!"
    exit 1
fi

# Simplify the port number when running only one flavor per server:
PORT=8004

echo "PORT is $PORT"

echo "killing flavor container:"
docker kill $FLAVOR
echo "removing flavor container:"
docker rm $FLAVOR

docker run -d \
    --name $FLAVOR \
    -p ${PORT}:${PORT} \
    --restart=always \
    --env-file .env \
    -e PORT=${PORT} \
    -it $DOCKER_REPO

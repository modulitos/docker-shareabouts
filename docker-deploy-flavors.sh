#!/bin/bash

DOCKER_REPO="$1"
# should be lukeswart/duwamish-flavors (new) or lukeswart/duwamish (old)
echo "docker repo is $DOCKER_REPO"

if [[ "$2" != "" ]]; then
    FLAVOR="$2"
else
    FLAVOR="duwamish_flavor"
fi

echo "selected FLAVOR is $FLAVOR"

flavors=(demo1 demo2 raingardens duwamish_flavor)

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

echo "PORT is $PORT"
command="./src/manage.py compilemessages && gunicorn wsgi:application -w 3 -b 0.0.0.0:${PORT} --log-level=debug"

echo "killing flavor container:"
docker kill $FLAVOR
echo "removing flavor container:"
docker rm $FLAVOR

docker run -d \
    --name $FLAVOR \
    -p ${PORT}:${PORT} \
    -e "FLAVOR=${FLAVOR}" \
    --env-file .env \
    -it $DOCKER_REPO \
    sh -c "${command}" 


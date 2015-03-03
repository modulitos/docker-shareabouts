#!/bin/bash
echo "killing container:"
docker kill nginx
echo "removing container:"
docker rm nginx

docker run -d \
  --name "nginx" \
  --volumes-from duwamish_flavor \
  --link duwamish_flavor:duwamish_flavor \
  -p 80:80 \
  -it lukeswart/duwamish-nginx


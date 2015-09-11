echo "killing container:"
docker kill nginx-api
echo "removing container:"
docker rm nginx-api

docker run -d \
       --name "nginx-api" \
       --volumes-from smartercleanup-api \
       -v $(pwd)/nginx.conf:/nginx.conf \
       --link smartercleanup-api:smartercleanup-api \
       -p 80:80 \
       -it lukeswart/api-nginx

       # -p 8010:8010 \
       # --restart=always \

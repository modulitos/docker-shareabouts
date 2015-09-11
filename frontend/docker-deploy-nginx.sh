CONTAINER_NAME="$3"
echo "killing container:"
docker kill $CONTAINER_NAME
echo "removing container:"
docker rm $CONTAINER_NAME

docker run -d \
       --name $CONTAINER_NAME \
       --volumes-from "$2" \
       -v $(pwd)/"$2"-nginx.conf:/nginx.conf \
       --link "$2":"$2" \
       -p 80:80 \
       -it "$1"

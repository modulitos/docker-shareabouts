docker kill smartercleanup-api
docker rm smartercleanup-api

docker run --name smartercleanup-api \
       --restart=always \
       --hostname=smartercleanup \
       --link test-postgis:postgis-api \
       --env-file .env \
       -d smartercleanup/api

       # -p 8010:8010 \
       # -d smartercleanup/api sh -c "python src/manage.py collectstatic --noinput && gunicorn wsgi:application -w 3 -b 0.0.0.0:8010"

# access the postgis container:
# docker run -it --link test-postgis:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

# access the api container:
# docker exec -it smartercleanup-api /bin/bash

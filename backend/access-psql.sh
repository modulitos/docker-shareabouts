docker run -it --link postgis:postgis --rm postgis sh -c 'exec psql -h "$POSTGIS_PORT_5432_TCP_ADDR" -p "$POSTGIS_PORT_5432_TCP_PORT" -U postgis'

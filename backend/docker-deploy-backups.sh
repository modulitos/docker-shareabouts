docker kill backups
docker rm backups

CMD="docker run --name="backups" \
        --hostname="localhost" \
        --restart=always \
	--env-file .backups-env \
        --link=test-postgis:backup-db \
        -v ~/postgres_data/smartercleanup-backups:/backups \
	-d -t \
 	kartoza/pg-backup:9.4"
# docker run --name="backups"\
#            --hostname="pg-backups" \
#            --link=watchkeeper_db_1:db \
#            -v backups:/backups \
#            -i -d kartoza/pg-backup:9.4

echo 'Running\n'
echo $CMD
eval $CMD

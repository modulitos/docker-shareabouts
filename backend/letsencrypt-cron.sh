#!/bin/bash

# Allow some time for our nginx webserver to start up
echo "starting letsencrypt-cron client"
sleep 6

# read in our args for the letsencrypt command, using the respective environment variables
domain_args="-d ${LETSENCRYPT_DOMAINS// / -d }"
echo "domain_args: $domain_args"

if [[ $LETSENCRYPT_DEBUG_MODE = 'false' ]]
then
    test_cert=''
else
    test_cert='--test-cert'
fi

email="--email $LETSENCRYPT_EMAIL"

# Call our letsencrypt command, using the first domain as the directory path for the cert
command="letsencrypt certonly $test_cert --standalone $domain_args --text --agree-tos $email --rsa-key-size 4096 --verbose --renew-by-default --standalone-supported-challenges http-01"
echo -e "our letsencrypt command:\n$command"
# Make the command an executable script:
echo $command > /letsencrypt
chmod 0755 /letsencrypt
# Add our letsencrpt command to our crontab:
# echo -e "00 23 * * * root /letsencrypt 2>&1 | /var/log/cron.log" > /etc/cron.d/letsencrypt
echo -e "*/2 * * * * root /letsencrypt 2>&1 | /var/log/cron.log" > /etc/cron.d/letsencrypt
echo "# An empty line is required at the end of this file for a valid cron file." >> /etc/cron.d/letsencrypt
chmod 0644 /etc/cron.d/letsencrypt
# TODO: Add a quiet option to prevent emails on every renewal check: https://github.com/letsencrypt/letsencrypt/issues/2512


echo "running letsencrypt client..."
# create our logging file, then redirect our output to that file:
touch /var/log/cron.log
bash /letsencrypt 2>&1 | tee /var/log/cron.log 

echo "starting cron"
cron && sleep 60 && tail -f /var/log/cron.log

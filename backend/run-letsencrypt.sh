#!/bin/bash

# Allow some time for our nginx webserver to start up
# echo "starting letsencrypt-cron client"
echo "starting letsencrypt client"
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

# Attempt at running our command using a bash array:
# # letsencrypt certonly --test-cert --standalone -d dev-api2.heyduwamish.org -d www.dev-api2.heyduwamish.org --text --agree-tos --email luke@smartercleanup.org --rsa-key-size 4096 --verbose --renew-by-default --standalone-supported-challenges http-01
# command=( letsencrypt certonly "$test_cert" --standalone "$domain_args" --test --agree-tos "$email" --rsa-key-size 4096 --verbose --renew-by-default --standalone-supported-challenges http-01)
# echo -e "our letsencrypt command:\n$command[@]"
# # execute it:
# "${command[@]}"
# sleep 60

# # Call our letsencrypt command, using the first domain as the directory path for the cert
# command="certbot certonly $test_cert --standalone $domain_args --text --agree-tos $email --rsa-key-size 4096 --verbose --keep-until-expiring --standalone-supported-challenges http-01"

command="certbot certonly $test_cert --standalone $domain_args --text --agree-tos $email --rsa-key-size 4096 --verbose --keep-until-expiring --preferred-challenges http"


# # command="letsencrypt certonly $test_cert --standalone $domain_args --text --agree-tos $email --rsa-key-size 4096 --verbose --renew-by-default --standalone-supported-challenges http-01"
# # command="letsencrypt certonly $test_cert --standalone $domain_args --text --agree-tos $email --server https://acme-v01.api.letsencrypt.org/directory --rsa-key-size 4096 --verbose --renew-by-default --standalone-supported-challenges http-01"

echo -e "our letsencrypt command:\n$command"

eval $command
# give ample time for our nginx server to connect to this host:
sleep 60

# TODO: Add a quiet option to prevent emails on every renewal check: https://github.com/letsencrypt/letsencrypt/issues/2512

#! /bin/bash

# This script sets the timezone of a docker container

# Relocate the timezone file
mkdir -p /config/etc && mv /etc/timezone /config/etc/ && ln -s /config/etc/timezone /etc/
# Set timezone as specified in /config/etc/timezone
dpkg-reconfigure -f noninteractive tzdata
# Set the time zone
echo "$TZ" > /config/etc/timezone
echo "Updated datetime is:"
date
echo ""


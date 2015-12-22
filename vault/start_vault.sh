#!/bin/sh
#
# Starupt script for development vault. Starts dev serfver with additonal listeners and creates a default token

echo "HELLO!"
vault server -dev -config /srv/config.hcl &

# Wait for startup
until vault status
do
    sleep 1
done

# Use this token for development access
DEV_ACCESS_TOKEN=001fdd19-468b-ef28-c256-b46684c0a6fa
vault token-create -id $DEV_ACCESS_TOKEN

# Wait for background process (vault server) to exit
wait

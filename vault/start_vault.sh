#!/bin/sh
#
# Starupt script for development vault. Starts dev serfver with additonal listeners and creates a default token

vault server -dev -dev-listen-address "0.0.0.0:8201" -config /srv/config.hcl &

export VAULT_ADDR="http://127.0.0.1:8201"
until vault status
do
    echo "Waiting for vault startup..."
    sleep 1
done

# Use this token for development access
DEV_ACCESS_TOKEN=001fdd19-468b-ef28-c256-b46684c0a6fa
vault token-create -id $DEV_ACCESS_TOKEN

# Wait for background process (vault server) to exit
wait

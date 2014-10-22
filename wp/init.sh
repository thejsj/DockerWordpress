#!/bin/bash

Check if DB_HOST is set
if [ -z "${DB_HOST}" ]; then
    DB_HOST=$WPDB_PORT_3306_TCP_ADDR;
fi;

# Create Bash file for environment variables
echo "export DB_NAME=${DB_NAME}" >> /envvars.sh
echo "export DB_USER=${DB_USER}" >> /envvars.sh
echo "export DB_HOST=${DB_HOST}" >> /envvars.sh
echo "export DB_PASS=${DB_PASS}" >> /envvars.sh
echo "export WPDB_PORT_3306_TCP_ADDR=${WPDB_PORT_3306_TCP_ADDR}" >> /envvars.sh

source /run.sh
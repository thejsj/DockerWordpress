#!/bin/bash

# Check if DB_HOST is set
if [ -z "${DB_HOST}" ]; then
    DB_HOST=$WPDB_PORT_3306_TCP_ADDR;
fi;

date -d @`date +%s` "+%T on %m/%d, %Y." >> /db.txt
echo "Current DB Details : ${DB_NAME} -- ${DB_USER} -- ${DB_HOST} -- ${DB_PASS}" >> /db.txt

# Add Config File
cd /app/wp/
rm wp-config.php
wp core config \
    --allow-root \
    --dbname="${DB_NAME}" \
    --dbuser="${DB_USER}" \
    --dbhost="${DB_HOST}" \
    --dbpass="${DB_PASS}" \
    --skip-check
echo "" >> /app/wp/wp-config.php
echo "/** ENABLE DEBUGGING **/" >> /app/wp/wp-config.php
echo "define( 'WP_DEBUG', true);" >> /app/wp/wp-config.php
echo "" >> /app/wp/wp-config.php
echo "/** SET SITE URL **/" >> /app/wp/wp-config.php
echo "define( 'WP_SITEURL', 'http://' . \$_SERVER['HTTP_HOST'] . '/wp' ); " >> /app/wp/wp-config.php
echo "define( 'WP_HOME', 'http://' . \$_SERVER['HTTP_HOST'] );" >> /app/wp/wp-config.php

# Install Wordpress
source /install_wp.sh

# Install Plugins and Themes
source /activate_plugins_and_themes.sh

# Apache
cd /
source /etc/apache2/envvars
exec apache2 -D FOREGROUND

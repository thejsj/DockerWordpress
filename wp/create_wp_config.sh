#!/bin/bash

echo "wp core config \
    --allow-root \
    --dbname=${DB_NAME} \
    --dbuser=${DB_USER} \
    --dbhost=${DB_HOST} \
    --dbpass=${DB_PASS}" >> /config-command.txt

cd /app/wp/
rm wp-config.php
wp core config \
    --allow-root \
    --dbname="${DB_NAME}" \
    --dbuser="${DB_USER}" \
    --dbhost="${DB_HOST}" \
    --dbpass="${DB_PASS}"
echo "" >> /app/wp/wp-config.php
echo "/** ENABLE DEBUGGING **/" >> /app/wp/wp-config.php
echo "define( 'WP_DEBUG', true);" >> /app/wp/wp-config.php
echo "" >> /app/wp/wp-config.php
echo "/** SET SITE URL **/" >> /app/wp/wp-config.php
echo "define( 'WP_SITEURL', 'http://' . \$_SERVER['HTTP_HOST'] . '/wp' ); " >> /app/wp/wp-config.php
echo "define( 'WP_HOME', 'http://' . \$_SERVER['HTTP_HOST'] );" >> /app/wp/wp-config.php
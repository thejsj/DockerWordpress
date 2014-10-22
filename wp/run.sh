#!/bin/bash

# Check if DB_HOST is set
if [ -z "${DB_HOST}" ]; then
    DB_HOST=$WPDB_PORT_3306_TCP_ADDR;
fi;

# Create DB if it doesn't exists
source /create_db.sh

# Add Config File
source /create_wp_config.sh

# Install Wordpress
source /install_wp.sh

# Install Plugins and Themes
source /activate_plugins_and_themes.sh

# Apache
cd /
source /etc/apache2/envvars
exec apache2 -D FOREGROUND

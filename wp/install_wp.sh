#!/bin/bash

# Install DB
cd /app/wp/
if ! $(wp core is-installed --allow-root); then \
    wp core install \
    --allow-root \
    --title='Some Title' \
    --admin_user='admin' \
    --admin_password='admin' \
    --admin_email='jorge.silva@thejsj.com' \
    --url='dockerhost' ; \
    fi
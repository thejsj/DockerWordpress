FROM ubuntu:trusty
MAINTAINER Co+Lab Multimedia

#
# Install packages (apache-php has already updated)
#

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# ESSENTIALS
RUN apt-get -yq install curl git software-properties-common wget emacs

# APACHE
RUN apt-get -yq install apache2

# PHP
RUN apt-get -yq install libapache2-mod-php5 php5-mysql php5-gd php5-curl php-pear php-apc

# Ruby
RUN apt-get -yq install ruby2.0 ruby2.0-dev bundler

# Node JS
RUN add-apt-repository ppa:chris-lea/node.js && apt-get update
RUN apt-get -yq install nodejs

# MySQL
RUN apt-get -yq install mysql-client

# Compass
RUN gem install rubygems-update
RUN update_rubygems
RUN gem install bundler --pre
RUN gem install sass compass

# NPM
RUN npm install -g gulp

# Configure PHP
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Remove Source Lists
RUN rm -rf /var/lib/apt/lists/*

#
# WordPress
#

## Download latest version of WordPress into /app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

## Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

## Install WordPress
RUN wp core download --allow-root --path='/app/wp/'

## Add Files
WORKDIR /
ADD wp/index.php /app/
ADD wp/.htaccess /app/
RUN chmod 644 /app/.htaccess

# Add Uploads Directory
RUN mkdir -p /app/wp/wp-content/uploads/
RUN chmod -R 777 /app/wp/wp-content

## Install Composer and Install Plugins
WORKDIR /app/wp/
RUN curl -sS https://getcomposer.org/installer | php
ADD wp/composer.json /app/wp/composer.json
RUN rm -rf /app/wp/wp-content/plugins
RUN mkdir -p /app/wp/wp-content/plugins
RUN export COMPOSER_HOME=/ && composer install

# Install Theme
WORKDIR /
ADD theme /app/wp/wp-content/themes/cork-gulp

# Install npm packages
WORKDIR /app/wp/wp-content/themes/cork-gulp
RUN npm install
RUN gulp build

#
# Apache/PHP
#

# Add image configuration and scripts
ADD wp/run.sh /run.sh
ADD wp/install_wp.sh /install_wp.sh
ADD wp/activate_plugins_and_themes.sh /activate_plugins_and_themes.sh
ADD wp/install_plugins.sh /install_plugins.sh
ADD wp/create_db.sh /create_db.sh
RUN chmod 755 /*.sh

## Add Domain configuration
RUN a2enmod rewrite
ADD wp/wordpress.conf /etc/apache2/sites-enabled/000-default.conf

# Make Uploads a persistent volume, who's files won't be deleted
RUN rm -rf /app/wp/wp-content/uploads
RUN ln -s /uploads /app/wp/wp-content

# Expose environment variables
RUN export DISPLAY=donner:0.0
RUN export TERM=xterm

# Add application code onbuild
RUN chmod -R 777 /app/wp/wp-content
RUN chown www-data:www-data /app -R
ONBUILD RUN chmod -R 777 /uploads
ONBUILD RUN chown -R www-data:www-data /uploads

EXPOSE 80
WORKDIR /
ENTRYPOINT ["/run.sh"]

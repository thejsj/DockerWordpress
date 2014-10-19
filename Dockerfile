FROM ubuntu:trusty
MAINTAINER Co+Lab Multimedia

#
# Install packages (apache-php has already updated)
#

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# ESSENTIALS
RUN apt-get -yq install curl git software-properties-common wget

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

# Install WordPress
RUN wp core download --allow-root --path='/app/wp/'
WORKDIR /app/wp
RUN wp core config --allow-root  --dbname='wp_test' --dbuser='root'  --dbhost='10.0.2.2'
RUN echo "\n/** ENABLE DEBUGGING **/" >> /app/wp/wp-config.php
RUN echo "define( 'WP_DEBUG', true);" >> /app/wp/wp-config.php
RUN echo "\n/** SET SITE URL **/" >> /app/wp/wp-config.php
RUN echo "define( 'WP_SITEURL', 'http://' . \$_SERVER['HTTP_HOST'] . '/wp' ); " >> /app/wp/wp-config.php
RUN echo "define( 'WP_HOME', 'http://' . \$_SERVER['HTTP_HOST'] );" >> /app/wp/wp-config.php
RUN if ! $(wp core is-installed --allow-root); \
    then wp core install \
    --allow-root \
    --title='Some Title' \
    --admin_user='admin' \
    --admin_password='admin' \
    --admin_email='jorge.silva@thejsj.com' \
    --url='dockerhost' ; \
    fi

## Install & Activate Plugins
WORKDIR /app/wp
RUN wp plugin install advanced-custom-fields --activate --allow-root
RUN wp plugin install regenerate-thumbnails --activate --allow-root
RUN wp plugin install wp-migrate-db --activate --allow-root
RUN wp plugin install wp-super-cache --activate --allow-root
RUN wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/acf-gallery.zip --activate --allow-root
RUN wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/acf-options-page.zip --activate --allow-root
RUN wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/acf-repeater.zip --activate --allow-root
RUN wp plugin install http://www.colab-plugin-repository.com.php54-3.ord1-1.websitetestlink.com/plugins/gravityforms_1.8.9.12.zip --activate --allow-root
RUN wp plugin uninstall hello --allow-root
RUN wp plugin uninstall akismet --allow-root

## Add Files
WORKDIR /
ADD wordpress/index.php /app/
ADD wordpress/.htaccess /app/
RUN chmod 644 /app/.htaccess

# Install & Active Theme
WORKDIR /
ADD cork-gulp /app/wp/wp-content/themes/cork-gulp
WORKDIR /app/wp/wp-content/themes
RUN wp theme activate cork-gulp --allow-root

# Add Uploads Directory
RUN mkdir -p /app/wp/wp-content/uploads/
RUN chmod -R 777 /app/wp/wp-content

# Install npm packages
WORKDIR /app/wp/wp-content/themes/cork-gulp
RUN npm install
RUN gulp build

#
# Apache/PHP
#

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

## Add Permalinks
RUN a2enmod rewrite
ADD wordpress.conf /etc/apache2/sites-enabled/000-default.conf

# Make Uploads a persistent volume, who's files won't be deleted
RUN rm -rf /app/wp/wp-content/uploads
RUN ln -s /uploads /app/wp/wp-content

# Add application code onbuild
ONBUILD RUN chmod -R 777 /app/wp/wp-content
ONBUILD RUN chown www-data:www-data /app -R
ONBUILD RUN chmod -R 777 /uploads
ONBUILD RUN chown -R www-data:www-data /uploads

EXPOSE 80
WORKDIR /
CMD ["/run.sh"]

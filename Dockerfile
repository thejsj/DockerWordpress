FROM tutum/apache-php:latest
MAINTAINER Co+Lab Multimedia

#
# Install packages
#
RUN apt-get update

## MySQL
RUN apt-get -yq install mysql-client wget

#
# WordPress
#

## Add Permalinks
RUN a2enmod rewrite
ADD wordpress.conf /etc/apache2/sites-enabled/000-default.conf

## Download latest version of WordPress into /app
RUN rm -fr /app

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
RUN if ! $(wp core is-installed --allow-root); then wp core install --allow-root --title='Some Title' --admin_user='admin' --admin_password='admin' --admin_email='jorge.silva@thejsj.com' --url='dockerhost' ; fi

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

## Install & Activate Plugins
WORKDIR /app/wp
RUN wp plugin install advanced-custom-fields --activate --allow-root
RUN wp plugin install regenerate-thumbnails --activate --allow-root
RUN wp plugin install wp-migrate-db --activate --allow-root
RUN wp plugin uninstall hello --allow-root
RUN wp plugin uninstall akismet --allow-root
# TODO: Install ACF Repater Field, ACF Options, Gravity forms through private online repo

#
# Install Front-end Stuff
#

## Stuff we need
RUN apt-get -yq install python-software-properties python g++
RUN apt-get -yq install git make software-properties-common

# Ruby (doesn't work)
RUN curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled --ruby=1.9.3
RUN /usr/local/rvm/scripts/rvm
RUN source /etc/profile.d/rvm.sh

## Install Node.js
RUN add-apt-repository ppa:chris-lea/node.js && apt-get update
RUN apt-get -yq install nodejs

## NPM
WORKDIR /app/wp/wp-content/themes/cork-gulp
RUN npm install -g gulp
RUN npm install

# ## Compass
WORKDIR /app/wp/wp-content/themes/cork-gulp
# RUN gem install rubygems-update
# RUN update_rubygems
# RUN gem install sass
# RUN gem install compass

# ## Compile
# WORKDIR /app/wp/wp-content/themes/cork-gulp
# RUN gulp build

EXPOSE 80

FROM tutum/apache-php:latest
MAINTAINER Co+Lab Multimedia

#
# Install packages
#
RUN apt-get update

## Stuff we need
RUN apt-get -yq install python-software-properties python g++ make software-properties-common

## MySQL
RUN apt-get -yq install mysql-client wget

# Ruby (doesn't work)
RUN apt-get -yq install ruby-full
RUN curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled --ruby=1.9.3


## Install Node.js
RUN add-apt-repository ppa:chris-lea/node.js && apt-get update
RUN apt-get -yq install nodejs

## I think this deletes our package sources ...?
RUN rm -rf /var/lib/apt/lists/*

#
# WordPress
#

## Add Permalinks
RUN a2enmod rewrite
ADD wordpress.conf /etc/apache2/sites-enabled/000-default.conf

## Download latest version of WordPress into /app
RUN rm -fr /app
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz 
RUN mv ./wordpress ./wp
RUN rm latest.tar.gz

## Add Files
ADD wordpress/wp-config.php /app/wp/
ADD wordpress/index.php /app/
ADD wordpress/.htaccess /app/
RUN chmod 644 /app/.htaccess
ADD cork-gulp /app/wp/wp-content

#
# Install Front-end Stuff
#

## NPM
RUN cd /app/wp/wp-content/themes/cork-gulp && npm install -g gulp
RUN cd /app/wp/wp-content/themes/cork-gulp && npm install

## Compass
RUN gem install rubygems-update
RUN update_rubygems
RUN gem install sass
RUN gem install compass

## Compile
RUN cd /app/wp/wp-content/themes/cork-gulp && gulp build

EXPOSE 80

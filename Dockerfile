FROM tutum/apache-php:latest
MAINTAINER Co+Lab Multimedia

# Install packages
RUN apt-get update && \
  apt-get -yq install mysql-client wget nano && \
  rm -rf /var/lib/apt/lists/*

# Add permalink feature
RUN a2enmod rewrite
ADD wordpress.conf /etc/apache2/sites-enabled/000-default.conf

# Download latest version of Wordpress into /app
RUN rm -fr /app
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz 
RUN mv ./wordpress ./wp
RUN rm latest.tar.gz
ADD wp-config.php /app/wp/

EXPOSE 80
VOLUME ["/app/wp/wp-content"]

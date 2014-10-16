FROM tutum/apache-php:latest
MAINTAINER Co+Lab Multimedia

# Install packages
RUN apt-get update
RUN apt-get -yq install mysql-client wget nano

# Make nano work (http://www.absolutelytech.com/2010/10/11/solved-term-environment-variable-not-set-in-guake/)
RUN echo -e "TERM=xterm\nexport TERM" >> ~/.bashrc && kill -9 $$

RUN rm -rf /var/lib/apt/lists/*

# Add Permalinks
RUN a2enmod rewrite
ADD wordpress.conf /etc/apache2/sites-enabled/000-default.conf

# Download latest version of WordPress into /app
RUN rm -fr /app
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz 
RUN mv ./wordpress ./wp
RUN rm latest.tar.gz

# Add Files
ADD wordpress/wp-config.php /app/wp/
ADD wordpress/index.php /app/
ADD wordpress/.htaccess /app/
RUN chmod 644 /app/.htaccess
ADD cork-gulp /app/wp/wp-content

EXPOSE 80
# VOLUME ["/app/wp/wp-content"]

# use php-apache base image
FROM php:7.2-apache

# envs
ENV WORDPRESS_DB_HOST localhost
ENV WORDPRESS_DB_NAME database_name_here
ENV WORDPRESS_DB_USER username_here
ENV WORDPRESS_DB_PASS password_here

# update sources
RUN apt-get clean
RUN apt-get update

# install packages
RUN apt-get install -qy unzip

# enable php mysqli extension
RUN docker-php-ext-install mysqli

# install wordpress app
RUN curl -O https://wordpress.org/wordpress-4.9.5.zip \
        && unzip wordpress-4.9.5.zip \
        && mv wordpress/* /var/www/html/

# configure wordpress app
COPY buildconf/wp-config.php /var/www/html/

# cleanup
RUN apt-get -qy autoremove \
    && apt-get remove -yq unzip \
    && rm wordpress-4.9.5.zip

# expose ports
EXPOSE 80

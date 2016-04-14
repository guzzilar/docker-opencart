FROM php:5.6-apache

RUN a2enmod rewrite expires

# Setup Docker's container environment
ENV DB_NAME opencart_test
ENV DB_USER root
ENV DB_PASSWD admin

# Avoid MySQL questions during installation
ENV DEBIAN_FRONTEND noninteractive
RUN echo mysql-server-5.6 mysql-server/root_password password $DB_PASSWD | debconf-set-selections
RUN echo mysql-server-5.6 mysql-server/root_password_again password $DB_PASSWD | debconf-set-selections

# Install libs
RUN apt-get update && apt-get install -y \
    mysql-client \
    mysql-server \
    wget \
    unzip \
    git \
    && docker-php-ext-install mysqli


# ===================================================================== #
WORKDIR /app
# ===================================================================== #
COPY build.sh ./build.sh
RUN chmod +x ./build.sh

RUN service mysql start \
    && mysql --user=$DB_USER --password=$DB_PASSWD --execute="CREATE DATABASE opencart_test;" \
    && mysql --user=$DB_USER --password=$DB_PASSWD --execute="SHOW DATABASES;"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
COPY composer.json ./composer.json
RUN php /usr/bin/composer install

RUN git clone https://github.com/opencart/opencart.git opencart


# ===================================================================== #
WORKDIR /app/opencart
# ===================================================================== #
RUN git checkout 1.5.6.4


# ===================================================================== #
WORKDIR /app
# ===================================================================== #
CMD ["./build.sh"]

EXPOSE 80

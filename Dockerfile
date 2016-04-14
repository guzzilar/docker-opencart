FROM php:5.6-apache

ENV DB_NAME opencart_test
ENV DB_USER root
ENV DB_PASSWD admin

# Avoid MySQL questions during installation
ENV DEBIAN_FRONTEND noninteractive
RUN echo mysql-server-5.6 mysql-server/root_password password $DB_PASSWD | debconf-set-selections
RUN echo mysql-server-5.6 mysql-server/root_password_again password $DB_PASSWD | debconf-set-selections

RUN apt-get update && apt-get install -y \
    mysql-client \
    mysql-server \
    wget \
    unzip \
    git

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

WORKDIR /app

# Copy the composer.json file to the WORKDIR and do install
COPY composer.json /app/composer.json
RUN php /usr/bin/composer install

COPY . /app/

EXPOSE 80

CMD ["./vendor/bin/phpunit", "tests"]

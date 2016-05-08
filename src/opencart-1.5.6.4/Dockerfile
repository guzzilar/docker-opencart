FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
        unzip \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \

    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \

    && docker-php-ext-install mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install gd

# WAIT-FOR-IT.sh
ADD ./wait-for-it.sh ./wait-for-it.sh
RUN chmod +x ./wait-for-it.sh

# INSTALL.sh
ADD ./install.sh ./opencart-1.5.6.4-install.sh
RUN chmod +x ./opencart-1.5.6.4-install.sh

ADD . ./opencart-1.5.6.4

EXPOSE 80

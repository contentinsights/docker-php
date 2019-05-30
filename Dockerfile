ARG PHP_VERSION=7.2
FROM php:${PHP_VERSION}-apache

ARG PHP_EXT="bcmath gd opcache pdo_pgsql pgsql"

ENV APACHE_DOCUMENT_ROOT=/var/www/public \
    PHP_VERSION=${PHP_VERSION}

RUN apt-get update \
    && \
    apt-get install --assume-yes libpng-dev libpq-dev \
    && \
    apt-get clean \
    && \
    docker-php-ext-install $PHP_EXT \
    && \
    sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

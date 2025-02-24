FROM php:8.3-fpm-bookworm

LABEL maintainer="nimdasx@gmail.com" \
    description="fpm php-8.3 phalcon-5.8"

#config php
COPY php-nimdasx.ini /usr/local/etc/php/conf.d/php-nimdasx.ini

#timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions ioncube_loader pdo_mysql pdo_pgsql gd zip mysqli xmlrpc redis sqlsrv pdo_sqlsrv phalcon-5.8.0

#dependensi
RUN apt-get -y update \
    && apt-get install -y \
    unzip \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/pear
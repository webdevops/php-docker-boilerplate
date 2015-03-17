FROM php:5.6-fpm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y \
    graphicsmagick \
    zip \
    unzip

RUN apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libicu-dev \
    libcurl3 \
    php5-json \
    php5-intl \
    php5-curl \
    php5-mysqlnd \
    php5-xhprof \
    php5-memcache \
    php5-mcrypt \
    php5-gd \
    php5-sqlite \
    php5-xmlrpc \
    php5-xsl \
    php5-geoip \
    php5-ldap \
    && docker-php-ext-install iconv mcrypt mysqli \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

ADD entrypoint.sh /entrypoint.sh

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]

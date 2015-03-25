FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y \
    php5-cli \
    php5-fpm \
    php5-json \
    php5-intl \
    php5-curl \
    php5-mysqlnd \
    php5-xhprof \
    php5-xdebug \
    php5-memcache \
    php5-mcrypt \
    php5-gd \
    php5-sqlite \
    php5-xmlrpc \
    php5-xsl \
    php5-geoip \
    php5-ldap

RUN apt-get install -y \
    graphicsmagick \
    zip \
    unzip \
    curl

ADD conf/php.ini /etc/php5/mods-available/typo3.ini
RUN php5enmod typo3

ADD entrypoint.sh /entrypoint.sh

EXPOSE 9000

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]
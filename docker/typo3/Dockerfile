FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    php5-cli \
    php5-fpm \
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
    graphicsmagick \
    mysql-client

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

ADD entrypoint.sh /entrypoint.sh
ADD ./htdocs /var/www/html

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["echo", "hello"]

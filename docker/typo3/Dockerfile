FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN mkdir -p /opt/docker/ /var/log/supervisor
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY bin/* /opt/docker/

RUN apt-get install -y \
    supervisor \
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
    php5-ldap

RUN apt-get install -y \
    graphicsmagick \
    zip \
    unzip \
    curl \
    mysql-client \
    nodejs \
    nodejs-legacy \
    node-less \
    npm

ADD conf/php.ini /etc/php5/mods-available/typo3.ini
RUN php5enmod typo3

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

ADD ./htdocs /var/www/htdocs


EXPOSE 9000

VOLUME /var/www/
WORKDIR /var/www/htdocs/

CMD ["/usr/bin/supervisord"]

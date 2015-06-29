#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

export DEBIAN_FRONTEND="noninteractive"

#############################
# Modify user
#############################

usermod --shell /bin/bash --home /home www-data
chown   www-data:www-data /home

## Fix terminal
echo 'export TERM="xterm-color"' >> /root/.bashrc
echo 'export TERM="xterm-color"' >> /home/.bashrc

#############################
# Common tasks
#############################

mkdir -p /opt/docker/ \
         /var/log/supervisor

#############################
# Install packages
#############################

apt-get update

apt-get install -y \
    sudo \
    supervisor \
    dnsmasq \
    ssmtp \
    php5-cli \
    php5-fpm \
    php5-json \
    php5-intl \
    php5-curl \
    php5-mysqlnd \
    php5-xdebug \
    php5-memcached \
    php5-mcrypt \
    php5-gd \
    php5-sqlite \
    php5-xmlrpc \
    php5-xsl \
    php5-geoip \
    php5-ldap \
    php5-memcache \
    php5-memcached

apt-get install -y \
    graphicsmagick \
    zip \
    unzip \
    wget \
    curl \
    mysql-client \
    moreutils \
    dnsutils

#############################
# Generate locales
#############################

cat /opt/docker/locale.conf >> /var/lib/locales/supported.d/local
locale-gen

#############################
# Enable php modules
#############################
## custom config
touch /etc/php5/mods-available/docker-boilerplate.ini
php5enmod docker-boilerplate

# enable ext mcrypt
php5enmod mcrypt

#############################
# Composer
#############################

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


#############################
# Dnsmasq
#############################

## Fix dnsmasqd
echo "
user=root
conf-dir=/etc/dnsmasq.d
" >> /etc/dnsmasq.conf

#############################
# Cleanup
#############################

apt-get clean -y
apt-get autoclean -y

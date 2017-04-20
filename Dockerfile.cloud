#++++++++++++++++++++++++++++++++++++++
# PHP application Docker container
#++++++++++++++++++++++++++++++++++++++
#
# PHP-Versions:
#  5.6          -> PHP 5.6         official PHP image
#  7.0          -> PHP 7.0         official PHP image
#  7.1          -> PHP 7.1         official PHP image
#  ubuntu-12.04 -> PHP 5.3         (precise)  LTS
#  ubuntu-14.04 -> PHP 5.5         (trusty)   LTS
#  ubuntu-15.04 -> PHP 5.6         (vivid)
#  ubuntu-15.10 -> PHP 5.6         (wily)
#  ubuntu-16.04 -> PHP 7.0         (xenial)   LTS
#  centos-7     -> PHP 5.4
#  debian-7     -> PHP 5.4         (wheezy)
#  debian-8     -> PHP 5.6 and 7.x (jessie)
#  debian-9     -> PHP 7.0         (stretch)
#
# Apache:
#   webdevops/php-apache:5.6
#   webdevops/php-apache:7.0
#   webdevops/php-apache:7.1
#   webdevops/php-apache:ubuntu-12.04
#   webdevops/php-apache:ubuntu-14.04
#   webdevops/php-apache:ubuntu-15.04
#   webdevops/php-apache:ubuntu-15.10
#   webdevops/php-apache:ubuntu-16.04
#   webdevops/php-apache:centos-7
#   webdevops/php-apache:debian-7
#   webdevops/php-apache:debian-8
#   webdevops/php-apache:debian-8-php7
#   webdevops/php-apache:debian-9
#
# Nginx:
#   webdevops/php-nginx:5.6
#   webdevops/php-nginx:7.0
#   webdevops/php-nginx:7.1
#   webdevops/php-nginx:ubuntu-12.04
#   webdevops/php-nginx:ubuntu-14.04
#   webdevops/php-nginx:ubuntu-15.04
#   webdevops/php-nginx:ubuntu-15.10
#   webdevops/php-nginx:ubuntu-16.04
#   webdevops/php-nginx:centos-7
#   webdevops/php-nginx:debian-7
#   webdevops/php-nginx:debian-8
#   webdevops/php-nginx:debian-8-php7
#   webdevops/php-nginx:debian-9
#
# HHVM:
#   webdevops/hhvm-apache
#   webdevops/hhvm-nginx
#
#++++++++++++++++++++++++++++++++++++++

FROM webdevops/php-apache:ubuntu-16.04

ENV PROVISION_CONTEXT "production"

# Deploy scripts/configurations
COPY etc/             /opt/docker/etc/

COPY app/             /app/

RUN ln -sf /opt/docker/etc/cron/crontab /etc/cron.d/docker-boilerplate \
    && chmod 0644 /opt/docker/etc/cron/crontab \
    && echo >> /opt/docker/etc/cron/crontab \
    && ln -sf /opt/docker/etc/php/production.ini /opt/docker/etc/php/php.ini

# Configure volume/workdir
WORKDIR /app/

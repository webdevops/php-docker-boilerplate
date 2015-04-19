#!/usr/bin/env bash

#############################
## Init PHP
#############################
echo "
date.timezone = ${PHP_TIMEZONE}
" >> /etc/php5/mods-available/docker-boilerplate.ini

#############################
## Init PHP-FPM
#############################

# Backup original
if [ ! -f "/opt/docker/.fpm-www.conf" ]; then
    cp /etc/php5/fpm/pool.d/www.conf /opt/docker/.fpm-www.conf
fi

## Remove old logs
rm -f -- /tmp/php.access.log /tmp/php.slow.log /tmp/php.error.log
touch -- /tmp/php.access.log /tmp/php.slow.log /tmp/php.error.log
chmod 666 /tmp/php.access.log /tmp/php.slow.log /tmp/php.error.log

# Restore original
cp /opt/docker/.fpm-www.conf  /etc/php5/fpm/pool.d/www.conf
sed -i "s@listen = /var/run/php5-fpm.sock@listen = 9000@" /etc/php5/fpm/pool.d/www.conf

# Manipulate php-fpm configuration
echo "
; Server resource settings

pm.max_children = 10
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3

catch_workers_output = yes

access.format = \"%R - %u %t \\\"%m %r%Q%q\\\" %s %f cpu:%C%% mem:%{megabytes}M reqTime:%d\"
access.log = /tmp/php.access.log
slowlog    = /tmp/php.slow.log
request_slowlog_timeout = 30s

php_admin_value[error_log] = /tmp/php.error.log
php_admin_flag[log_errors] = on

env[TYPO3_CONTEXT]    = ${TYPO3_CONTEXT}
env[FLOW_CONTEXT]     = ${FLOW_CONTEXT}
env[FLOW_REWRITEURLS] = ${FLOW_REWRITEURLS}
" >> /etc/php5/fpm/pool.d/www.conf

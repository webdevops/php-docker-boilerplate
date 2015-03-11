#!/bin/bash

sed -i "s@listen = /var/run/php5-fpm.sock@listen = 9000@" /etc/php5/fpm/pool.d/www.conf

echo "
env[TYPO3_CONTEXT] = ${TYPO3_CONTEXT}

php_value[short_open_tag]    = On
php_value[variables_order]   = 'GPCS'
php_value[request_order]     = 'GP'

php_value[allow_url_fopen]   = On
php_value[allow_url_include] = Off

php_value[memory_limit]              = 512M
php_value[max_execution_time]        = 300
php_value[max_input_time]            = 300
php_admin_value[post_max_size]       = 50M
php_admin_value[upload_max_filesize] = 50M

" >> /etc/php5/fpm/pool.d/www.conf

exec /usr/sbin/php5-fpm --nodaemonize

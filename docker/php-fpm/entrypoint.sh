#!/bin/bash

# Backup original
if [ ! -f "/usr/local/etc/.php-fpm.conf.default.original" ]; then
    cp /usr/local/etc/php-fpm.conf.default /usr/local/etc/.php-fpm.conf.default.original
fi

# Restore original
cp /usr/local/etc/.php-fpm.conf.default.original  /usr/local/etc/php-fpm.conf.default

# Manipulate phpfpm configuration
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

" >> /usr/local/etc/php-fpm.conf.default

exec php-fpm --nodaemonize

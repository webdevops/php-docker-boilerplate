#!/bin/bash

# Backup original
if [ ! -f "/usr/local/etc/.php-fpm.conf.default.original" ]; then
cp /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/.www.original
fi

# Restore original
cp /etc/php5/fpm/pool.d/.www.original  /etc/php5/fpm/pool.d/www.conf
sed -i "s@listen = /var/run/php5-fpm.sock@listen = 9000@" /etc/php5/fpm/pool.d/www.conf

# Manipulate php-fpm configuration
echo "
env[TYPO3_CONTEXT]    = ${TYPO3_CONTEXT}
env[FLOW_CONTEXT]     = ${FLOW_CONTEXT}
env[FLOW_REWRITEURLS] = ${FLOW_REWRITEURLS}
" >> /etc/php5/fpm/pool.d/www.conf

exec /usr/sbin/php5-fpm --nodaemonize

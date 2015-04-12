#!/bin/bash
set -e

#############################
## Init MySQL
#############################

echo "[client]
host=mysql
user=\"$MYSQL_USER\"
password=\"$MYSQL_PASSWORD\"

[mysql]
host=mysql
user=\"$MYSQL_USER\"
password=\"$MYSQL_PASSWORD\"
database=\"$MYSQL_DATABASE\"
default-character-set=utf8
local-infile=1
show-warnings
auto-rehash
sigint-ignore
reconnect

[mysqldump]
host=mysql
user=\"$MYSQL_USER\"
password=\"$MYSQL_PASSWORD\"

" | tee /root/.my.cnf > /home/.my.cnf

#############################
## Init SSMTP
#############################

sed -i "s/mailhub=.*/mailhub=${MAIL_GATEWAY}/" /etc/ssmtp/ssmtp.conf

#############################
## Init PHP-FPM
#############################

# Backup original
if [ ! -f "/opt/docker/.fpm-www.conf" ]; then
    cp /etc/php5/fpm/pool.d/www.conf /opt/docker/.fpm-www.conf
fi

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

access.log = /proc/self/fd/2
slowlog    = /proc/self/fd/2
request_slowlog_timeout = 30s

php_admin_value[error_log] = /proc/self/fd/2

env[TYPO3_CONTEXT]    = ${TYPO3_CONTEXT}
env[FLOW_CONTEXT]     = ${FLOW_CONTEXT}
env[FLOW_REWRITEURLS] = ${FLOW_REWRITEURLS}
" >> /etc/php5/fpm/pool.d/www.conf

#############################
## COMMAND
#############################

case "$1" in

    ## Supervisord (start daemons)
    supervisord)
        ## Register IP
        ETH0_IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
        echo "${ETH0_IP}"                 > /data/dns/main.ip
        echo "${ETH0_IP}   httpd httpd_1" > /data/dns/main.hosts

        ## Start services
        exec supervisord
        ;;

    ## Root shell
    root)
        if [ "$#" -eq 1 ]; then
            ## No command, fall back to shell
            exec bash
        else
            ## Exec root command
            shift
            exec "$@"
        fi
        ;;

    ## All other commands
    *)
        ## Set home dir (workaround)
        export HOME=/home/
        ## Execute cmd
        sudo -E -u www-data "$@"
        ;;
esac

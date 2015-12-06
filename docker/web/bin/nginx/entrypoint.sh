#!/bin/bash

###################
# UID/GID
###################

## Set uid/gid for www-data user
usermod  --uid "${EFFECTIVE_UID}" --shell /bin/bash --home /home nginx > /dev/null
groupmod --gid "${EFFECTIVE_GID}" nginx > /dev/null

###################
# vhost
###################

# Detect correct path of document root
DOCUMENT_ROOT=$(readlink -f "/docker/$DOCUMENT_ROOT")

ALIAS_DOMAIN=""
for DOMAIN in $DNS_DOMAIN; do
    ALIAS_DOMAIN="${ALIAS_DOMAIN} *.${DOMAIN}"
done

rm -f -- /etc/nginx/conf.d/*.conf
cp /opt/docker/vhost.conf /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<DOCUMENT_ROOT>@${DOCUMENT_ROOT}@"              /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<DOCUMENT_INDEX>@${DOCUMENT_INDEX}@"            /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<ALIAS_DOMAIN>@${ALIAS_DOMAIN}@"                /etc/nginx/conf.d/vhost.conf

/bin/sed -i "s@<FPM_HOST>@${MAIN_PORT_9000_TCP_ADDR}@"         /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FPM_PORT>@${MAIN_PORT_9000_TCP_PORT}@"         /etc/nginx/conf.d/vhost.conf

/bin/sed -i "s@<MYSQL_USER>@${MYSQL_USER}@"                    /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<MYSQL_PASSWORD>@${MYSQL_PASSWORD}@"            /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<MYSQL_ROOT_PASSWORD>@${MYSQL_ROOT_PASSWORD}@"  /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<MYSQL_DATABASE>@${MYSQL_DATABASE}@"            /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<MYSQL_HOST>@${MYSQL_HOST}@"                    /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<MYSQL_PORT>@${MYSQL_PORT}@"                    /etc/nginx/conf.d/vhost.conf

/bin/sed -i "s@<POSTGRES_USER>@${POSTGRES_USER}@"              /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<POSTGRES_PASSWORD>@${POSTGRES_PASSWORD}@"      /etc/nginx/conf.d/vhost.conf

#############################
## COMMAND
#############################

if [ "$1" = 'nginx' ]; then
    ## Register IP
    ETH0_IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
    mkdir -p /data/dns/
    chmod 777 /data/dns/
    echo "${ETH0_IP}"             > /data/dns/web.ip
    echo "${ETH0_IP}   web web_1" > /data/dns/web.hosts

    exec nginx -g "daemon off;"
fi

exec "$@"

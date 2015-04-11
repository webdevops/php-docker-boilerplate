#!/bin/bash

###################
# vhost
###################

# Detect correct path of document root
DOCUMENT_ROOT=$(readlink -f "/docker/$DOCUMENT_ROOT")

rm -f -- /etc/nginx/conf.d/*.conf
cp /opt/docker/vhost.conf /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<DOCUMENT_ROOT>@${DOCUMENT_ROOT}@"         /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<DOCUMENT_INDEX>@${DOCUMENT_INDEX}@"       /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<TYPO3_CONTEXT>@${TYPO3_CONTEXT}@"         /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FLOW_CONTEXT>@${FLOW_CONTEXT}@"           /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FLOW_REWRITEURLS>@${FLOW_REWRITEURLS}@"   /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FPM_HOST>@${MAIN_PORT_9000_TCP_ADDR}@"    /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FPM_PORT>@${MAIN_PORT_9000_TCP_PORT}@"    /etc/nginx/conf.d/vhost.conf

#############################
## COMMAND
#############################

if [ "$1" = 'nginx' ]; then
    ## Register in consul (if available)
    if [ -n "${CONSUL_PORT_8500_TCP_ADDR}" ]; then
        ETH0_IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

        curl -XPUT http://${CONSUL_PORT_8500_TCP_ADDR}:8500/v1/agent/service/register \
        -d "{
            \"ID\"      : \"container_nginx\",
            \"Name\"    : \"nginx\",
            \"Port\"    : 80,
            \"tags\"    : [\"nginx\", \"web\"],
            \"Address\" : \"${ETH0_IP}\"
        }"
    fi

    exec nginx -g "daemon off;"
fi

exec "$@"

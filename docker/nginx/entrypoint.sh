#!/bin/bash

###################
# vhost
###################

# Detect correct path of document root
DOCUMENT_ROOT=$(readlink -f "/docker/$DOCUMENT_ROOT")

rm -f -- /etc/nginx/conf.d/*.conf
cp /opt/docker/vhost.conf /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<DOCUMENT_ROOT>@${DOCUMENT_ROOT}@"         /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<TYPO3_CONTEXT>@${TYPO3_CONTEXT}@"         /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FLOW_CONTEXT>@${FLOW_CONTEXT}@"           /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FLOW_REWRITEURLS>@${FLOW_REWRITEURLS}@"   /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FPM_HOST>@${MAIN_PORT_9000_TCP_ADDR}@"    /etc/nginx/conf.d/vhost.conf
/bin/sed -i "s@<FPM_PORT>@${MAIN_PORT_9000_TCP_PORT}@"    /etc/nginx/conf.d/vhost.conf

#############################
## COMMAND
#############################

if [ "$1" = 'nginx' ]; then
    exec nginx -g "daemon off;"
fi

exec "$@"
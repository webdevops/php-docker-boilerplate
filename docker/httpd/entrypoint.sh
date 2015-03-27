#!/bin/bash

###################
# httpd.conf
###################

# Backup original
if [ ! -f "/usr/local/apache2/conf/.httpd.conf.original" ]; then
    cp /usr/local/apache2/conf/httpd.conf /usr/local/apache2/conf/.httpd.conf.original
fi

cp /usr/local/apache2/conf/.httpd.conf.original /usr/local/apache2/conf/httpd.conf

echo "
Include conf/docker-vhost.conf
" >> /usr/local/apache2/conf/httpd.conf


###################
# docker-vhost.conf
###################

cp /usr/local/apache2/conf/.docker-vhost.conf.original   /usr/local/apache2/conf/docker-vhost.conf
/bin/sed -i "s@<TYPO3_CONTEXT>@${TYPO3_CONTEXT}@"        /usr/local/apache2/conf/docker-vhost.conf
/bin/sed -i "s@<FLOW_CONTEXT>@${FLOW_CONTEXT}@"          /usr/local/apache2/conf/docker-vhost.conf
/bin/sed -i "s@<FLOW_REWRITEURLS>@${FLOW_REWRITEURLS}@"  /usr/local/apache2/conf/docker-vhost.conf
/bin/sed -i "s@<FPM_HOST>@${TYPO3_PORT_9000_TCP_ADDR}@"    /usr/local/apache2/conf/docker-vhost.conf
/bin/sed -i "s@<FPM_PORT>@${TYPO3_PORT_9000_TCP_PORT}@"    /usr/local/apache2/conf/docker-vhost.conf


httpd -DFOREGROUND
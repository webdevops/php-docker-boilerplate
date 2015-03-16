#!/bin/bash


echo "
Include conf/docker-vhost.conf
" >> /usr/local/apache2/conf/httpd.conf

/bin/sed -i "s@<TYPO3_CONTEXT>@${TYPO3_CONTEXT}@"     /usr/local/apache2/conf/docker-vhost.conf
/bin/sed -i "s@<FPM_HOST>@${FPM_PORT_9000_TCP_ADDR}@" /usr/local/apache2/conf/docker-vhost.conf
/bin/sed -i "s@<FPM_PORT>@${FPM_PORT_9000_TCP_PORT}@" /usr/local/apache2/conf/docker-vhost.conf


httpd -DFOREGROUND
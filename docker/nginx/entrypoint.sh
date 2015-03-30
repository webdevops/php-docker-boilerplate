#!/bin/bash

cp /etc/nginx/sites-available/default.tpl /etc/nginx/sites-enabled/default
/bin/sed -i "s@<TYPO3_CONTEXT>@${TYPO3_CONTEXT}@"         /etc/nginx/sites-enabled/default
/bin/sed -i "s@<FLOW_CONTEXT>@${FLOW_CONTEXT}@"           /etc/nginx/sites-enabled/default
/bin/sed -i "s@<FLOW_REWRITEURLS>@${FLOW_REWRITEURLS}@"   /etc/nginx/sites-enabled/default
/bin/sed -i "s@<FPM_HOST>@${MAIN_PORT_9000_TCP_ADDR}@"    /etc/nginx/sites-enabled/default
/bin/sed -i "s@<FPM_PORT>@${MAIN_PORT_9000_TCP_PORT}@"    /etc/nginx/sites-enabled/default

#############################
## COMMAND
#############################

if [ "$1" = 'nginx' ]; then
    exec nginx
fi

exec "$@"
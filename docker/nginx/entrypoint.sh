#!/bin/bash

cp /etc/nginx/sites-available/default.tpl /etc/nginx/sites-enabled/default
/bin/sed -i "s@<TYPO3_CONTEXT>@${TYPO3_CONTEXT}@"     /etc/nginx/sites-enabled/default
/bin/sed -i "s@<FPM_HOST>@${FPM_PORT_9000_TCP_ADDR}@" /etc/nginx/sites-enabled/default
/bin/sed -i "s@<FPM_PORT>@${FPM_PORT_9000_TCP_PORT}@" /etc/nginx/sites-enabled/default

nginx
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

" > /root/.my.cnf

#############################
## Init SSMTP
#############################

sed -i "s/mailhub=.*/mailhub=${MAIL_GATEWAY}/" /etc/ssmtp/ssmtp.conf

#############################
## COMMAND
#############################

if [ "$1" = 'supervisord' ]; then
    exec supervisord
fi

exec "$@"
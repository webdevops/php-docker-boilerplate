#!/usr/bin/env bash

#############################
## Init MySQL
#############################

echo "[client]
host=mysql
user=\"root\"
password=\"$MYSQL_ROOT_PASSWORD\"

[mysql]
host=mysql
user=\"root\"
password=\"$MYSQL_ROOT_PASSWORD\"
database=\"$MYSQL_DATABASE\"
default-character-set=utf8
local-infile=1
show-warnings
auto-rehash
sigint-ignore
reconnect

[mysqldump]
host=mysql
user=\"root\"
password=\"$MYSQL_ROOT_PASSWORD\"

" | tee /root/.my.cnf > /home/.my.cnf

#!/bin/bash

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

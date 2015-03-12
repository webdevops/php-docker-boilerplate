#!/bin/bash

# Open root user access for development
if [ -n "$MYSQL_ROOT_PASSWORD" ]; then
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
fi
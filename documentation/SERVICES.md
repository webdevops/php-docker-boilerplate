[<-- Back to main section](../README.md)

# Services

### Main (Nginx or Apache HTTPd)

Setting       | Value
------------- | -------------
Host          | web:80 and web:443 (ssl)
External Port | 8000 and 8443 (ssl)

### MySQL

You can choose between [MySQL](https://www.mysql.com/) (default), [MariaDB](https://www.mariadb.org/)
and [PerconaDB](http://www.percona.com/software) in `docker/mysql/Dockerfile`

Setting       | Value
------------- | -------------
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Database      | database (if not changed in env)
Host          | mysql:3306
External Port | 13306

Access fo MySQL user "root" and "dev" will be allowed from external hosts (eg. for debugging, dumps and other stuff).


### PostgreSQL

Setting       | Value
------------- | -------------
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Host          | postgres:5432
External Port | 15432


### Solr

Setting       | Value
------------- | -------------
Host          | solr:8983
External Port | 18983
Cores         | docker/solr/conf/solr.xml (data dirs are created automatically)

### Elasticsearch (disabled by default)

Setting       | Value
------------- | -------------
Host          | elasticsearch:9200 and :9300
External Port | 19200 and 19300

### Redis

Setting       | Value
------------- | -------------
Host          | redis
Port          | 6379

### Memcached

Setting       | Value
------------- | -------------
Host          | memcached
Port          | 11211

### Mailcatcher

Setting       | Value
------------- | -------------
Host          | mail
SMTP port     | 1025
Web port      | 1080

### FTP

Setting       | Value
------------- | -------------
Host          | ftp
Ports         | 20,21
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Path          | /storage/ftp (if not changed in env)

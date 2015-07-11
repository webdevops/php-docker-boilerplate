[<-- Back to main section](../README.md)

# Docker container informations

## Docker layout

Container                 | Description
------------------------- | -------------------------------
main                      | Main container with PHP-FPM and tools (your entrypoint for bash, php and other stuff)
storage                   | Storage container, eg. for Solr data
web                       | Apache HTTPD or Nginx webserver
mysql                     | MySQL database
postgres (optional)       | PostgreSQL database
solr (optional)           | Apache Solr server
elasticsearch (optional)  | Elasticsearch server
memcached (optional)      | Memcached server
redis (optional)          | Redis server
ftps (optional)           | FTP server (vsftpd)
mailcatcher (optional)    | Mailserver with easy web and REST interface for mailing

This directory will be mounted under `/docker` in `main` and `web` container.

## Docker images
Container                 | Source
------------------------- | -------------------------------
main/ubuntu               | [Ubuntu](https://registry.hub.docker.com/_/ubuntu/) *official*
main/centos               | [CentOS](https://registry.hub.docker.com/_/centos/) *official*
storage                   | [Ubuntu](https://registry.hub.docker.com/_/ubuntu/) *official*
web                       | [Apache](https://registry.hub.docker.com/_/httpd/) *official* or [Nginx](https://registry.hub.docker.com/_/nginx/) *official*
mysql                     | [MySQL](https://registry.hub.docker.com/_/mysql/) *official*
postgres                  | [PostgreSQL](https://registry.hub.docker.com/_/postgres/) *official*
solr (optional)           | [Solr](https://registry.hub.docker.com/u/guywithnose/solr/) from _guywithnose_
elasticsearch (optional)  | [Elasticsearch](https://registry.hub.docker.com/_/elasticsearch/) *official*
memcached (optional)      | [Memcached](https://registry.hub.docker.com/_/memcached/) *official*
redis (optional)          | [Redis](https://registry.hub.docker.com/_/redis/) *official*
ftp (optional)            | [Ubuntu](https://registry.hub.docker.com/_/ubuntu/) *official*
mailcatcher (optional)    | [Mailcatcher](https://registry.hub.docker.com/u/schickling/mailcatcher/) from _schickling_

## Makefile

Customize the [Makefile](Makefile) for your needs.

Command                   | Description
------------------------- | -------------------------------
make bash                 | Enter main container with bash (user www-data)
make root                 | Enter main container with bash (user root)
<br>                      |
make backup               | General backup (run all backup tasks)
make restore              | General restore (run all restore tasks)
<br>                      |
make mysql-backup         | Backup MySQL databases
make mysql-restore        | Restore MySQL databases
<br>                      |
make solr-backup          | Backup Solr cores
make solr-restore         | Restore Solr cores
<br>                      |
make build                | Run building (composer, gulp, bower)

## Docker containers

### Web (Nginx or Apache HTTPd)

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
Path          | /data/ftp (if not changed in env)

## Environment settings

Environment           | Description
--------------------- | -------------
DOCUMENT_ROOT         | Document root for Nginx and Apache HTTPD, can be absolute or relative (to /docker inside the container).
DOCUMENT_INDEX        | Default document index file for Nginx and Apache HTTPd
CLI_SCRIPT            | Target for "cli" command of main container
CLI_USER              | User which should be used to run CLI scripts (normally www-data, equals php-fpm user)
<br>                  |
TYPO3_CONTEXT         | Context for TYPO3, can be used for TypoScript conditions and AdditionalConfiguration
FLOW_CONTEXT          | Context for FLOW and NEOS
<br>                  |
MAIL_GATEWAY          | Upstream server for sending mails (ssmtp)
DNS_DOMAIN            | List of wildcard domains pointing to webserver (eg. for local content fetching)
<br>                  |
MYSQL_ROOT_PASSWORD   | Password for MySQL user "root"
MYSQL_USER            | Initial created MySQL user
MYSQL_PASSWORD        | Password for initial MySQL user
MYSQL_DATABASE        | Initial created MySQL database
<br>                  |
PHP_TIMEZONE          | Timezone (date.timezone) setting for PHP (cli and fpm)
EFFECTIVE_UID         | Effective UID for php, fpm und webserver
EFFECTIVE_GID         | Effective GID for php, fpm und webserver

## Xdebug Remote debugger (PhpStorm)

Add a server (Preferences -> PHP -> Servers):

Setting                 | Value
----------------------- | -------------
Hostname                | IP or Hostname of VM
Port                    | 8000
Use path mappings       | Check
Path mapping of code    | /docker/code/

Add a debug connection (Run -> Edit -> Connections) and create a new connection.

Setting               | Value
--------------------- | -------------
Server                | Server you created before
Start URL             | /
Browser               | Choose one

Save, set a break point and test the debugger.

## Application cache

Symlink your application cache (eg. typo3temp/) to `/data/cache/` and it will be stored inside the `storage` container
so it will be accessable within all containers (eg. web or main).

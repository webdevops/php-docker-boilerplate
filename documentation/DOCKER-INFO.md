[<-- Back to main section](../README.md)

# Docker container informations

## Docker layout

Container                 | Description
------------------------- | -------------------------------
app                       | PHP application container with nginx/apache and PHP-FPM and tools (your entrypoint for bash, php and other stuff)
storage                   | Storage container, eg. for Solr data
mysql                     | MySQL database
postgres (optional)       | PostgreSQL database
solr (optional)           | Apache Solr server
elasticsearch (optional)  | Elasticsearch server
memcached (optional)      | Memcached server
redis (optional)          | Redis server
ftps (optional)           | FTP server (vsftpd)
mailcatcher (optional)    | Mailserver with easy web and REST interface for mailing

The `app/` directory will be mounted under `/app` inside `app` container.

## Docker images
Container                 | Source
------------------------- | -------------------------------
app                       | [WebDevOps Images](https://registry.hub.docker.com/u/webdevops/)
storage                   | [Ubuntu](https://registry.hub.docker.com/_/ubuntu/) *official*
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
make bash                 | Enter main container with bash (user application)
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
MYSQL_HOST            | MySQL Hostname
MYSQL_PORT            | Port that the MySQL instance is using
<br>                  |
PHP_TIMEZONE          | Timezone (date.timezone) setting for PHP (cli and fpm)
EFFECTIVE_UID         | Effective UID for php, fpm und webserver
EFFECTIVE_GID         | Effective GID for php, fpm und webserver

## Xdebug Remote debugger (PhpStorm)

### 1.) Add a server (Preferences -> Languages & Frameworks -> PHP -> Servers).

Setting                          | Value
---------------------------------| -------------
Hostname                         | IP or Hostname of VM
Port                             | 8000
Debugger                         | Xdebug  
Use path mappings                | Check
Path mapping of folder 'app'     | /app/

### 2.) Add a debug connection (Run -> Edit Configurations... -> Connections) and create a new configuration (PHP Web Application).

Setting               | Value
--------------------- | -------------
Server                | Server you created before
Start URL             | /
Browser               | Choose one

Save, set a break point and test the debugger.

## Application cache

Symlink your application cache (eg. typo3temp/) to `/storage/cache/` and it will be stored inside the `storage` container
so it will be accessible within all containers (eg. web or main).

# Dockerized PHP web project boilerplate

![latest v3.2.0](https://img.shields.io/badge/latest-v3.2.0-green.svg?style=flat)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/mblaschke/typo3-docker-boilerplate.svg)](http://isitmaintained.com/project/mblaschke/typo3-docker-boilerplate "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/mblaschke/typo3-docker-boilerplate.svg)](http://isitmaintained.com/project/mblaschke/typo3-docker-boilerplate "Percentage of issues still open")


This is a boilerplate utilizing Docker based with support
for **TYPO3_CONTEXT** and **FLOW_CONTEXT** for TYPO3, FLOW, NEOS.
It also supports Symfony and any other PHP base project.

Supports:

- Nginx or Apache HTTPd
- PHP-FPM (with Xdebug and Xhprof)
- MySQL, MariaDB or PerconaDB
- Solr (disabled, without EXT:solr configuration)
- Elasticsearch (disabled, without configuration)
- Redis (disabled)
- Memcached (disabled)
- maybe more later...

This Docker boilerplate based on the best practises and don't use too much magic.
Configuration of each docker container is available in the `docker/` directory - feel free to customize.

This boilerplate can also be used for any other web project eg. Symfony, Magento and more.
Just customize the makefile for your needs

Warning: Don't use this Docker containers for production - they are only for development!

Use can use my [Vagrant Development VM](https://github.com/mblaschke/vagrant-development) for this Docker boilerplate.

## Requirements

- GNU/Linux with Docker (recommendation: Vagrant VM with Docker or native Linux with Docker)
- make
- [composer](https://getcomposer.org/)
- [docker-compose](https://github.com/docker/compose)

If you want to run a Docker VM make sure you're using VMware or Parallels Desktop because of
the much faster virtualisation (networking, disk access, shared folders) compared to VirtualBox.

For more convenience use [CliTools.phar](https://github.com/mblaschke/vagrant-clitools) (will also run on native Linux, not only Vagrant)

## Docker short introduction

Create and start containers (eg. first start):

    $ docker-compose up -d

Stop containers

    $ docker-compose stop

Start containers (only stopped containers)

    $ docker-compose start

Build (but not create and start) containers

    $ docker-compose build --no-cache

Delete container content

    $ docker-compose rm --force

Recreate containers (if there is any issue or just to start from a clean build)

    $ docker-compose stop
    $ docker-compose rm --force
    $ docker-compose build --no-cache
    $ docker-compose up -d

Logs (eg. for debugging)

    $ docker-compose logs

    # or only php
    $ docker-compose logs main

    # or only php and webserver
    $ docker-compose logs main web

CLI script (defined in docker-env.yml)

    $ docker-compose run --rm main cli help


## Create project

First create and run the Docker containers using [docker-compose](https://github.com/docker/compose):

    $ docker-compose up -d

Now create the project:

- [Create new TYPO3 project](doc/README-TYPO3.md)
- [Create new NEOS project](doc/README-NEOS.md)
- [Create new Symfony project](doc/README-SYMFONY.md)
- [Running any other php based project](doc/README-OTHER.md)
- [Running existing project](doc/README-EXISTING.md)

For an existing project just put your files into `code/` folder or use git to clone your project into `code/`.


## Informations

### Docker layout

Container                 | Description
------------------------- | -------------------------------
main                      | Main container with PHP-FPM and tools (your entrypoint for bash, php and other stuff)
storage                   | Storage container, eg. for Solr data
web                       | Apache HTTPD or Nginx webserver
mysql                     | MySQL database
solr                      | Apache Solr server
elasticsearch (optional)  | Elasticsearch server
memcached (optional)      | Memcached server
redis (optional)          | Redis server

This directory will be mounted under `/docker` in `main` and `web` container.

### Makefile

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
make create-cms-project   | Create new TYPO3 project (based on typo3/cms-base-distribution)
make create-neos-project  | Create new NEOS project (based on typo3/neos-base-distribution)
<br>                      |
make deploy               | Run deployment (composer, gulp, bower)
make scheduler            | Run TYPO3 scheduler
make clean                | Clear TYPO3 configuration cache


### MySQL

You can choose between [MySQL](https://www.mysql.com/) (default), [MariaDB](https://www.mariadb.org/)
and [PerconaDB](http://www.percona.com/software) in `docker/mysql/Dockerfile`

Setting       | Value
------------- | -------------
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Database      | typo3 (if not changed in env)
Host          | mysql:3306
External Port | 13306

Access fo MySQL user "root" and "dev" will be allowed from external hosts (eg. for debugging, dumps and other stuff).


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

### Environment settings

Environment           | Description
--------------------- | -------------
DOCUMENT_ROOT         | Document root for Nginx and Apache HTTPD, can be absolute or relative (to /docker inside the container).
DOCUMENT_INDEX        | Default document index file for Nginx and Apache HTTPd
CLI_SCRIPT            | Target for "cli" command of main container
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
PHP_UID               | Effective UID for www-data (cli and fpm)
PHP_GID               | Effective GID for www-data (cli and fpm)

### Xdebug Remote debugger (PhpStorm)

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

## Advanced usage (git)

Use this boilerplate as template and customize it for each project. Put this Docker
configuration for each project into seperate git repositories.

Now set your existing project repository to be a git submodule in `code/`.
Every developer now needs only to clone the Docker repository with **--recursive**
to get both, the Docker configuration and the TYPO3 installation.

For better useability track a whole branch (eg. develop or master) as submodule and not just a single commit.

## Credits

This Docker layout is based on https://github.com/denderello/symfony-docker-example/

Thanks to [cron IT GmbH](http://www.cron.eu/) for the inspiration for this Docker boilerplate.

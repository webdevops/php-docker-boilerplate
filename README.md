# Dockerized TYPO3, FLOW and NEOS project boilerplate

This is a boilerplate utilizing Docker based with support
for **TYPO3_CONTEXT** and **FLOW_CONTEXT** for TYPO3, FLOW and NEOS projects.

Supports:

- Nginx or Apache HTTPd
- PHP-FPM (with Xdebug and Xhprof)
- MySQL, MariaDB or PerconaDB
- Solr
- Elasticsearch (disabled, without configuration)
- Redis (disabeld)
- Memcached (disabeld)
- maybe more later...

This Docker boilerplate based on the best practises and don't use too much magic.
Configuration of each docker container is availabe in the docker/ directory - feel free to customize.

This boilerplate can also be used for any other web project eg. Symfony, Magento and more.
Just customize the makefile for your needs

Warning: Don't use this Docker containers for production - they are only for development!

## Requirements

- GNU/Linux with Docker (recommendation: Vagrant VM with Docker or native Linux with Docker)
- make
- [composer](https://getcomposer.org/)
- [docker-compose](https://github.com/docker/compose)

If you want to run a Docker VM make sure you're using VMware or Parallels Desktop because of
the much faster virtualisation (networking, disk access, shared folders) compared to VirtualBox.


## Create new project

First create and run the Docker containers using [docker-compose](https://github.com/docker/compose):

    $ docker-compose up -d

Now create the project:

- [Create new TYPO3](README-TYPO3.md)
- [Create new NEOS](README-NEOS.md)

For an existing project just put your files into htdocs/ folder or use git to clone your project into htdocs.


## Informations


### Makefile

Customize the [Makefile](Makefile) for your needs.

Command                   | Description
------------------------- | -------------------------------
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
and [PerconaDB](http://www.percona.com/software) in docker/mysql/Dockerfile

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
TYPO3_CONTEXT         | Context for TYPO3, can be used for TypoScript conditions and AdditionalConfiguration
FLOW_CONTEXT          | Context for FLOW and NEOS
<br>                  |
MYSQL_ROOT_PASSWORD   | Password for MySQL user "root"
MYSQL_USER            | Initial created MySQL user
MYSQL_PASSWORD        | Password for initial MySQL user
MYSQL_DATABASE        | Initial created MySQL database

### Xdebug Remote debugger (PhpStorm)

Add a server (Preferences -> PHP -> Servers):

Setting                 | Value
----------------------- | -------------
Hostname                | IP or Hostname of VM
Port                    | 8000
Use path mappings       | Check
Path mapping of htdocs  | /var/www/htdocs/

Add a debug connection (Run -> Edit -> Connections) and create a new connection.

Setting               | Value
--------------------- | -------------
Server                | Server you created before
Start URL             | /
Browser               | Choose one

Save, set a break point and test the debugger.

## Advanced usage (git)

Use this boilerplate as template and customize it for each project. Put this Docker
configuration for each project into seperate git repositories.

Now set your existing project repository to be a git submodule in htdocs/.
Every developer now needs only to clone the Docker repository with **--recursive**
to get both, the Docker configuration and the TYPO3 installation.

For better useability track a whole branch (eg. develop or master) as submodule and not just a single commit.

## Credits

This Docker layout is based on https://github.com/denderello/symfony-docker-example/

Thanks to [cron IT GmbH](http://www.cron.eu/) for the inspiration for this Docker boilerplate.
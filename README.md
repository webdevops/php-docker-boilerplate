# Dockerized TYPO3 Project

A TYPO3 boilerplate project utilizing Docker based on
**PHP-FPM, nginx, MySQL and Solr** with support for **TYPO3_CONTEXT**.

This Docker boilerplate based on the best practises and don't use too much magic.
Configuration of each docker container is availabe in the docker/ directory - feel free to customize.

Based on https://github.com/denderello/symfony-docker-example/

Warning: Don't use this Docker containers for production - they're for development!


## Requirements

- GNU/Linux with Docker (recommendation: Vagrant or native)
- make
- [composer](https://getcomposer.org/)
- [docker-compose](https://github.com/docker/compose)

If you want to run a Docker VM make sure you're using VMware or Parallels Desktop because of
the much faster virtualisation (networking, disk access, shared folders) compared to VirtualBox.


## Running

You can run the Docker environment using [docker-compose](https://github.com/docker/compose):

    $ docker-compose up -d

### Create TYPO3 project

For the first TYPO3 Setup (make sure [composer](https://getcomposer.org/) is installed):

    $ make create-project

or

    $ rm -f htdocs/.gitkeep
    $ composer create-project typo3/cms-base-distribution htdocs/
    $ touch htdocs/FIRST_INSTALL htdocs/.gitkeep


Feel free to modify your TYPO3 installation in your htdocs (shared folder of Docker),
most of the time there is no need to enter any Docker container.


### Existing TYPO3 project

Just put your TYPO3 project inside the htdocs folder or use git to checkout your project into htdocs.


### TYPO3 cli runner

You can run one-shot command inside the `TYPO3` service container:

    $ docker-compose run --rm typo3 typo3/cli_dispatch.phpsh scheduler

    $ docker-compose run typo3 bash

Webserver is available at Port 8000


## Informations


### Makefile

Command                | Description
---------------------- | -------------------------------
make clean             | Clear TYPO3 configuration cache
make mysql-backup      | Backup MySQL database
make mysql-restore     | Restore MySQL database
make deploy            | Run deployment (composer, gulp, bower)
make create-project    | Create new TYPO3 project (based on typo3/cms-base-distribution)
make scheduler         | Run TYPO3 scheduler


### MySQL

Setting       | Value
------------- | -------------
User          | dev (if not changed in env)
Password      | dev (if not changed in env)
Database      | typo3 (if not changed in env)
Host          | mysql:3306

Access fo MySQL user "root" and "dev" will be allowed from external hosts (eg. for debugging, dumps and other stuff).


### Solr

Setting       | Value
------------- | -------------
Host          | solr:8983
Cores         | docker/solr/conf/solr.xml (data dirs are created automatically)


### Environment settings

Environment           | Description
--------------------- | -------------
TYPO3_CONTEXT         | Context for TYPO3, can be used for TypoScript conditions and AdditionalConfiguration
<br>                  |
MYSQL_ROOT_PASSWORD   | Password for MySQL user "root"
MYSQL_USER            | Initial created MySQL user
MYSQL_PASSWORD        | Password for initial MySQL user
MYSQL_DATABASE        | Initial created MySQL database

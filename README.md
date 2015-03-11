#Dockerized TYPO3 Project

A TYPO3 boilerplate project utilizing Docker based on **PHP-FPM, nginx and MySQL** with support for **TYPO3_CONTEXT**.

This Docker boilerplate based on the best practises and don't use too much magic.
Configuration of each docker container is availabe in the docker/ directory - feel free to customize.

Based on https://github.com/denderello/symfony-docker-example/

## Running

You can run the Docker environment using [docker-compose](https://github.com/docker/compose):

    $ docker-compose up -d

For the first TYPO3 Setup (make sure [composer](https://getcomposer.org/) is installed):

    $ make create-project

or

    $ rm -f htdocs/.gitkeep
    $ composer create-project typo3/cms-base-distribution htdocs/
    $ touch htdocs/FIRST_INSTALL htdocs/.gitkeep

Feel free to modify your TYPO3 installation in your htdocs (shared folder of Docker), most of the time there is no need to enter any Docker container.

You can run one-shot command inside the `TYPO3` service container:

    $ docker-compose run --rm typo3 typo3/cli_dispatch.phpsh scheduler

    $ docker-compose run typo3 bash

Webserver is available at Port 8000

## Informations

### Makefile commands

Command                | Description
---------------------- | -------------------------------
make clean             | Clear TYPO3 configuration cache
make mysql-backup      | Backup MySQL database
make mysql-restore     | Restore MySQL database
make deploy            | Run deployment (composer, gulp, bower)
make create-project    | Create new TYPO3 project
make scheduler         | Run TYPO3 scheduler

### MySQL connection

Setting       | Value
------------- | -------------
User          | dev
Password      | dev
Database      | typo3
Host          | mysql:3306

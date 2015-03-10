#Dockerized TYPO3 Project

A TYPO3 boilerplate project utilizing Docker based on PHP-FPM, nginx and MySQL with support for TYPO3_CONTEXT.

Based on https://github.com/denderello/symfony-docker-example/

## Running

You can run the Docker environment using [docker-compose](https://github.com/docker/compose):

    $ docker-compose up -d

For TYPO3 Setup:

    $ cd htdocs
    $ composer install

Feel free to modify your TYPO3 installation in your htdocs (shared folder of Docker), most of the time there is no need to enter any Docker container.

You can run one-shot command inside the `TYPO3` service container:

    $ docker-compose run --rm typo3 typo3/cli_dispatch.phpsh scheduler

    $ docker-compose run typo3 bash


Database connection:
    User: root
    Password: dev
    Host: mysql
#Dockerized TYPO3 Project

A TYPO3 boilerplate project utilizing Docker based on PHP-FPM, nginx and MySQL with support for TYPO3_CONTEXT

Based on https://github.com/denderello/symfony-docker-example/

## Running

You can run the Docker environment using [docker-compose](https://github.com/docker/compose):

    $ docker-compose up -d
    $ cd htdocs
    $ composer install

You can run one-shot command inside the `TYPO3` service container:

    $  docker-compose run --rm typo3 typo3/cli_dispatch.phpsh scheduler

TYPO3 installation is accessable in ./htdocs/ and will be shared into Docker containers.
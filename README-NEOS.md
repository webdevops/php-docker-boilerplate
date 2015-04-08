[<-- Back to main section](README.md)

# Running NEOS

## Create NEOS project

For the first NEOS setup (make sure [composer](https://getcomposer.org/) is installed):

    $ make create-project neos

or

    $ rm -f code/.gitkeep
    $ composer create-project typo3/neos-base-distribution code/
    $ touch code/.gitkeep


And change `DOCUMENT_ROOT` in `docker-env.yml`:

    DOCUMENT_ROOT=code/Web/

Feel free to modify your NEOS installation in your `code` (a shared folder of Docker),
most of the time there is no need to enter any Docker container.

## NEOS cli runner

You can run one-shot command inside the `main` service container:

    $ docker-compose run --rm code flow core:setfilepermissions

    $ docker-compose run --rm code bash

Webserver is available at Port 8000
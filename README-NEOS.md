[<-- Back to main section](README.md)

# Running NEOS

## Create NEOS project

For the first NEOS setup (make sure [composer](https://getcomposer.org/) is installed):

    $ make create-neos-project

or

    $ rm -f htdocs/.gitkeep
    $ composer create-project typo3/neos-base-distribution htdocs/
    $ touch htdocs/.gitkeep


Feel free to modify your NEOS installation in your htdocs (a shared folder of Docker),
most of the time there is no need to enter any Docker container.


## NEOS cli runner

You can run one-shot command inside the `TYPO3` service container:

    $ docker-compose run --rm code flow core:setfilepermissions

    $ docker-compose run --rm code bash

Webserver is available at Port 8000
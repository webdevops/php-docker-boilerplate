[<-- Back to main section](../README.md)

# Running any existing project

## Create project

Checkout your git repository

    $ make create-project git https://github..../

or manually

    $ git clone --recursive https://github..../ code/

Check `DOCUMENT_ROOT` and `DOCUMENT_INDEX` in `docker-env.yml`

## Cli runner

You can run one-shot command inside the `main` service container:

    $ docker-compose run --rm main any-php-file.php argument1 argument2

    $ docker-compose run --rm main bash

Webserver is available at Port 8000

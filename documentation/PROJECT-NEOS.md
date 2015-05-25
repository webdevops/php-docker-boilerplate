[<-- Back to main section](DOCKER-STARTUP.md)

# Running NEOS

## Create NEOS project

For the first NEOS setup (make sure [composer](https://getcomposer.org/) is installed):

```bash
make create-project neos
```

or

```bash
rm -f code/.gitkeep
composer create-project typo3/neos-base-distribution code/
touch code/.gitkeep
```

And change `DOCUMENT_ROOT` in `docker-env.yml`:

    DOCUMENT_ROOT=code/Web/

Feel free to modify your NEOS installation in your `code` (a shared folder of Docker),
most of the time there is no need to enter any Docker container.

## NEOS cli runner

You can run one-shot command inside the `main` service container:

```bash
# commands with root rights
docker-compose run --rm main root ./flow core:setfilepermissions

# normal commands
docker-compose run --rm main ./flow core:anyothercommand

docker-compose run --rm main bash
```


Webserver is available at Port 8000

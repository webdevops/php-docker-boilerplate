[<-- Back to main section](DOCKER-STARTUP.md)

# Running NEOS

## Create NEOS project

For the first NEOS setup (make sure [composer](https://getcomposer.org/) is installed):

```bash
make create neos
```

or

```bash
rm -f app/.gitkeep
composer create-project typo3/neos-base-distribution app/
touch app/.gitkeep
```

And change `DOCUMENT_ROOT` in `docker-env.yml`:

    DOCUMENT_ROOT=/app/Web/

Feel free to modify your NEOS installation in your `app/` (a shared folder of Docker),
most of the time there is no need to enter any Docker container.

## NEOS cli runner

You can run one-shot command inside the `app` service container:

```bash
# commands with root rights
docker-compose run --rm app root ./flow core:setfilepermissions

# normal commands
docker-compose run --rm app ./flow core:anyothercommand

docker-compose run --rm app bash
```


Webserver is available at Port 8000

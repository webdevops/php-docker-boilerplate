[<-- Back to main section](../README.md)

# Running SYMFONY

## Create SYMFONY project

```bash
make create symfony
```

And change `DOCUMENT_ROOT` and `DOCUMENT_ROOT` in `docker-environment.yml`:

    DOCUMENT_ROOT=code/web/
    DOCUMENT_INDEX=app_dev.php

## SYMFONY cli runner

You can run one-shot command inside the `main` service container:

```bash
docker-compose run --rm main php code/app/console
docker-compose run --rm main bash
```

Webserver is available at Port 8000

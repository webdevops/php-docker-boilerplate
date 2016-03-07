[<-- Back to main section](../README.md)

# Running any existing project

## Create project

Checkout your git repository

```bash
make create git https://github..../
```

or manually
```bash
git clone --recursive https://github..../ app/
```

Check `DOCUMENT_ROOT` and `DOCUMENT_INDEX` in `etc/environment*.yml`

## Cli runner

You can run one-shot command inside the `app` service container:

```bash
docker-compose run --rm app any-php-file.php argument1 argument2
docker-compose run --rm app bash
```

Webserver is available at Port 8000

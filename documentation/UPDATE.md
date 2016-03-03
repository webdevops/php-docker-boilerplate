[<-- Back to main section](../README.md)

# Update

## Preparation

If you have cloned the git repository it's safe to pull the new version.

If you have used a zip file make sure to replace the `docker/` directory and also
update `docker-compose.yml` and `docker-environment.yml`.

For [changes see CHANGELOG.md](/CHANGELOG.md)

## Upgrade to 5.0.x
Because of a huge refactoring you need to rebuild the `app` container. The `web` container isn't used anymore.

```bash
docker-compose stop
docker-compose rm --force app
docker-compose build --no-cache web
docker-compose up
```

## Update to 3.4.x
As `PHP_UID` was replaced with `EFFECTIVE_UID` and `PHP_GID` was replaced with `EFFECTIVE_GID` you
have to rebuild all containers with this variables: `main` and `web`

```bash
docker-compose stop
docker-compose rm --force app
docker-compose build --no-cache web
docker-compose up
```

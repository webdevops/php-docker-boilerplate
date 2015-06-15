[<-- Back to main section](../README.md)

# Update

# Update to 3.4.x
As `PHP_UID` was replaced with `EFFECTIVE_UID` and `PHP_GID` was replaced with `EFFECTIVE_GID` you
have to rebuild all containers with this variables: `main` and `web`

```bash
docker-compose stop
docker-compose rm --force main web
docker-compose build --no-cache main web
docker-compose up
```

[<-- Back to main section](../README.md)

# Customizing

## Custom packages (`app` controller)

You can add custom commands in `Dockerfile.*`

## Custom php.ini directives

Modify the `etc/php/development.ini` or `etc/php/production.ini`, it will be added on top of the default php.ini so
you can overwrite any directives.

After modification rebuild your `app` container:

```bash
docker-compose stop
docker-compose build app
docker-compose up -d
```

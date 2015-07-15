[<-- Back to main section](../README.md)

# Customizing

## Custom packages (`main` controller)

You can add custom shell commands in `docker/main/{DISTRIBUTION}/bin/customization.sh`


## Custom php.ini directives

Modify the `docker/main/{DISTRIBUTION}/conf/php.ini`, it will be added on top of the default php.ini so
you can overwrite any directives.

After modification rebuild your `main` container:

```bash
docker-compose stop
docker-compose build main
docker-compose up -d
```

[<-- Back to main section](../README.md)

# Troubleshooting

## Startup or (docker) linking errors (safe reset)

If you got any startup issues you can try to rebuild `main` and `web` containers.
You won't lose any data with this way - it's a safe reset.

```bash
docker-compose stop
docker-compose rm --force main web
docker-compose build --no-cache main web
docker-compose up -d
```

## Complete reset

Reset all containers, delete all data (`mysql`, `solr` ..) but not your project files in `code/`!

```bash
docker-compose stop
docker-compose rm --force
docker-compose build --no-cache
docker-compose up -d
```


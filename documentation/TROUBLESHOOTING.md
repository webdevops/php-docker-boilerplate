[<-- Back to main section](../README.md)

# Troubleshooting

## Startup or (docker) linking errors

If you got any startup issues you can try to rebuild `main` and `web` containers:

```bash
docker-compose stop
docker-compose rm --force main web
docker-compose build --no-cache main web
docker-compose up -d
```

[<-- Back to main section](README.md)

# Running any php based project

## Create project

- Put your project files into `code/`
- If needed modify `DOCUMENT_ROOT` and `DOCUMENT_INDEX` in `docker-env.yml`
- You're done - really

## Cli runner

You can run one-shot command inside the `main` service container:

    $ docker-compose run --rm code any-php-file.php argument1 argument2

    $ docker-compose run --rm code bash

Webserver is available at Port 8000
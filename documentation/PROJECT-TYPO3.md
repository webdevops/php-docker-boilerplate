[<-- Back to main section](../README.md)

# Running TYPO3

## Create TYPO3 project

For the first TYPO3 setup (make sure [composer](https://getcomposer.org/) is installed):

```bash
make create typo3
```

or

```bash
rm -f app/.gitkeep
composer create-project typo3/cms-base-distribution app/
touch app/FIRST_INSTALL app/.gitkeep
```

Feel free to modify your TYPO3 installation in your `app/` (a shared folder of Docker),
most of the time there is no need to enter any Docker container.


## TYPO3 cli runner

You can run one-shot command inside the `app` service container:

```bash
docker-compose run --rm app typo3/cli_dispatch.phpsh scheduler
docker-compose run --rm app bash
```

Webserver is available at Port 8000


## Error: Trusted Host pattern

Set in htdocs/typo3conf/LocalConfiguration.php:

    'SYS' => array(
        [ ... ],
        'trustedHostsPattern' => '.*',
    ),

Should not be needed on Apache HTTPd.

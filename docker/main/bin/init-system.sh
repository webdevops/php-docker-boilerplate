#!/usr/bin/env bash

## Set uid/gid for www-data user
usermod  --uid "${PHP_UID}" --shell /bin/bash --home /home www-data > /dev/null
groupmod --gid "${PHP_GID}" www-data > /dev/null

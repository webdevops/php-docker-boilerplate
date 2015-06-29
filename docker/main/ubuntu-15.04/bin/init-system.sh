#!/usr/bin/env bash

## Set uid/gid for www-data user
usermod  --uid "${EFFECTIVE_UID}" --shell /bin/bash --home /home www-data > /dev/null
groupmod --gid "${EFFECTIVE_GID}" www-data > /dev/null

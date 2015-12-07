#!/bin/bash

trap 'echo sigterm ; exit' SIGTERM
trap 'echo sigkill ; exit' SIGKILL

# Fix code rights
chown -R "$EFFECTIVE_UID":"$EFFECTIVE_GID" /docker/code/

#############################
## COMMAND
#############################

if [ "$1" = 'noop' ]; then
    while true; do
        sleep 1
    done
fi

exec "$@"

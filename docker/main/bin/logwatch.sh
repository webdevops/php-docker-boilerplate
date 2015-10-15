#!/usr/bin/env bash

trap 'echo sigterm ; exit' SIGTERM
trap 'echo sigkill ; exit' SIGKILL

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

LOG_FACILITY="$1"
LOG_FILE="$2"

# Create pipe
if [ -f "${LOG_FILE}" ]; then
    mknod "${LOG_FILE}" p
fi

# Output content
while true; do
    sed --unbuffered -e "s/^/\[${LOG_FACILITY}\] /" < "${LOG_FILE}"
done

#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

export PYTHONUNBUFFERED=1

ANSIBLE_DIR='/opt/docker/provision'

ANSIBLE_TAG="$*"

# workaround if windows
chmod -x "$ANSIBLE_DIR/inventory"

# run ansible
ansible-playbook "$ANSIBLE_DIR/playbook.yml" --inventory="$ANSIBLE_DIR/inventory" --tags="${ANSIBLE_TAG}"

#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

export DEBIAN_FRONTEND="noninteractive"

# workaround for slow/freezing apt inside docker(?)
echo 'Acquire::http::Pipeline-Depth "0";' >> /etc/apt/apt.conf.d/00no-pipeline

if [ -z "`which ansible`" ]; then
    # install apt-add-repository if needed
    if [ -z "`which apt-add-repository`" ]; then

        apt-get update -q
        apt-get install -y --no-install-recommends lsb-release


        if [ "`lsb_release -r -s`" = '12.04' ]; then
            apt-get install -y python-software-properties
        else
            apt-get install -y software-properties-common
        fi
    fi

    # Register and install ansible
    apt-add-repository ppa:ansible/ansible
    apt-get update -q
    apt-get install -y ansible python-apt aptitude
fi
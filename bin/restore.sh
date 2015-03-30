#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

if [ "$#" -ne 1 ]; then
    echo "No type defined"
    exit 1
fi

mkdir -p -- "${BACKUP_DIR}"

case "$1" in
    ###################################
    ## MySQL
    ###################################
    "mysql")
        bzcat "${BACKUP_DIR}/${BACKUP_MYSQL_FILE}" | mysql
        ;;

    ###################################
    ## Solr
    ###################################
    "solr")
        rm -rf /data/solr/* && mkdir -p /data/solr/
        tar jxf "${BACKUP_DIR}/${BACKUP_SOLR_FILE}" -C /
        ;;
esac
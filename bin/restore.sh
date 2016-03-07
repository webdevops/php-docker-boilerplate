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
        if [ -f "${BACKUP_DIR}/${BACKUP_MYSQL_FILE}" ]; then
            logMsg "Starting MySQL restore..."
            bzcat "${BACKUP_DIR}/${BACKUP_MYSQL_FILE}" | mysql
            logMsg "Finished"
        else
            errorMsg "MySQL backup file not found"
            exit 1
        fi
        ;;

    ###################################
    ## Solr
    ###################################
    "solr")
        if [ -f "${BACKUP_DIR}/${BACKUP_SOLR_FILE}" ]; then
            logMsg "Starting Solr restore..."
            rm -rf /storage/solr/* && mkdir -p /storage/solr/
            chmod 777 /storage/solr/
            tar jxPf "${BACKUP_DIR}/${BACKUP_SOLR_FILE}" -C /
            logMsg "Finished"
        else
            errorMsg "Solr backup file not found"
            exit 1
        fi
        ;;
esac

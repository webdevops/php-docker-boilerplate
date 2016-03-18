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
            logMsg "Removing old backup file..."
            rm -f -- "${BACKUP_DIR}/${BACKUP_MYSQL_FILE}"
        fi

        logMsg "Starting MySQL backup..."
        dockerExec mysqldump --opt --single-transaction --events --all-databases --routines --comments | bzip2 > "${BACKUP_DIR}/${BACKUP_MYSQL_FILE}"
        logMsg "Finished"
        ;;

    ###################################
    ## Solr
    ###################################
    "solr")
        if [[ -n "$(dockerContainerId solr)" ]]; then
            logMsg "Starting Solr backup..."
            docker-compose stop solr

            if [ -f "${BACKUP_DIR}/${BACKUP_SOLR_FILE}" ]; then
                logMsg "Removing old backup file..."
                rm -f -- "${BACKUP_DIR}/${BACKUP_SOLR_FILE}"
            fi
            dockerExec tar -cP --to-stdout /storage/solr/ | bzip2 > "${BACKUP_DIR}/${BACKUP_SOLR_FILE}"

            docker-compose start solr
            logMsg "Finished"
        else
            echo "[WARNING] Skipping solr backup, no such container"
        fi
        ;;
esac

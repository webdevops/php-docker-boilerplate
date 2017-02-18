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
        if [[ -n "$(dockerContainerId mysql)" ]]; then
            if [ -f "${BACKUP_DIR}/${BACKUP_MYSQL_FILE}" ]; then
                logMsg "Starting MySQL restore..."
                MYSQL_ROOT_PASSWORD=$(dockerExecMySQL printenv MYSQL_ROOT_PASSWORD)
                bzcat "${BACKUP_DIR}/${BACKUP_MYSQL_FILE}" | dockerExecMySQL mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}"
                echo "FLUSH PRIVILEGES;" | dockerExec mysql -h mysql -u root -p"${MYSQL_ROOT_PASSWORD}"
                logMsg "Finished"
            else
                errorMsg "MySQL backup file not found"
                exit 1
            fi
        else
            echo " * Skipping mysql restore, no such container"
        fi
        ;;

    ###################################
    ## Solr
    ###################################
    "solr")
        if [[ -n "$(dockerContainerId solr)" ]]; then
            if [ -f "${BACKUP_DIR}/${BACKUP_SOLR_FILE}" ]; then
                logMsg "Starting Solr restore..."
                docker-compose stop solr

                dockerExec rm -rf /storage/solr/
                dockerExec mkdir -p /storage/solr/
                dockerExec chmod 777 /storage/solr/
                dockerCopyTo "${BACKUP_DIR}/${BACKUP_SOLR_FILE}" "/tmp/solr-restore.tbz2"
                dockerExec tar -jxPf "/tmp/solr-restore.tbz2" -C /

                docker-compose start solr
                logMsg "Finished"
            else
                errorMsg "Solr backup file not found"
                exit 1
            fi
        else
            echo " * Skipping solr restore, no such container"
        fi
        ;;
esac

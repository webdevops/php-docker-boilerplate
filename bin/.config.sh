#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value


#######################################
## Configuration
#######################################

READLINK='readlink'
unamestr=`uname`
if [ "$unamestr" == 'FreeBSD' -o "$unamestr" == 'Darwin'  ]; then
  READLINK='greadlink'
fi

if [ -z "`which $READLINK`" ]; then
    echo '$READLINK not installed'
fi

SCRIPT_DIR=$(dirname $($READLINK -f "$0"))
ROOT_DIR=$($READLINK -f "$SCRIPT_DIR/../")
CODE_DIR=$($READLINK -f "$ROOT_DIR/code")

BACKUP_DIR=$($READLINK -f "$ROOT_DIR/backup")
BACKUP_SOLR_FILE='solr.cores.tbz2'
BACKUP_MYSQL_FILE='mysql.sql.bz2'

#######################################
## Functions
#######################################

errorMsg() {
    echo "[ERR] $*"
}

sectionHeader() {
    echo "*** $* ***"
}

execInDir() {
    echo "[RUN :: $1] $2"

    sh -c "cd \"$1\" && $2"
}

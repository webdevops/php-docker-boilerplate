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
    echo "[ERROR] $READLINK not installed"
    echo "        make sure coreutils are installed"
    echo "        MacOS: brew install coreutils"
    exit 1
fi

SCRIPT_DIR=$(dirname "$($READLINK -f "$0")")
ROOT_DIR=$($READLINK -f "$SCRIPT_DIR/../")
CODE_DIR=$($READLINK -f "$ROOT_DIR/app")

BACKUP_DIR=$($READLINK -f "$ROOT_DIR/backup")
BACKUP_SOLR_FILE='solr.cores.tbz2'
BACKUP_MYSQL_FILE='mysql.sql.bz2'

#######################################
## Functions
#######################################

errorMsg() {
    echo "[ERROR] $*"
}

logMsg() {
    echo " * $*"
}

sectionHeader() {
    echo "*** $* ***"
}

execInDir() {
    echo "[RUN :: $1] $2"

    sh -c "cd \"$1\" && $2"
}

dockerContainerId() {
    echo "$(docker-compose ps -q "$1" 2> /dev/null || echo "")"
}

dockerExec() {
    docker exec -i "$(docker-compose ps -q app)" "$@"
}

dockerExecMySQL() {
    docker exec -i "$(docker-compose ps -q mysql)" "$@"
}

dockerCopyFrom() {
    PATH_DOCKER="$1"
    PATH_HOST="$2"
    docker cp "$(docker-compose ps -q app):${PATH_DOCKER}" "${PATH_HOST}"
}
dockerCopyTo() {
    PATH_HOST="$1"
    PATH_DOCKER="$2"
    docker cp "${PATH_HOST}" "$(docker-compose ps -q app):${PATH_DOCKER}"
}

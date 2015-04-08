#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

if [ "$#" -lt 1 ]; then
    echo "No project type defined (either cms, neos, symfony or git)"
    exit 1
fi

mkdir -p -- "$CODE_DIR/"
chmod 777 "$CODE_DIR/"

rm -f -- "$CODE_DIR/.gitkeep"

case "$1" in
    ###################################
    ## TYPO3 CMS
    ###################################
    "typo3")
        execInDir "$CODE_DIR" "composer create-project typo3/cms-base-distribution \"$CODE_DIR\""
        execInDir "$CODE_DIR" "touch FIRST_INSTALL"
        ;;

    ###################################
    ## TYPO3 NEOS
    ###################################
    "neos")
        execInDir "$CODE_DIR" "composer create-project typo3/neos-base-distribution \"$CODE_DIR\""
        ;;

    ###################################
    ## SYMFONY
    ###################################
    "symfony")
        curl -LsS http://symfony.com/installer > /tmp/symfony.$$.phar
        execInDir "$CODE_DIR" "php /tmp/symfony.$$.phar new '$CODE_DIR'"
        rm -f -- /tmp/symfony.$$.phar
        ;;

    ###################################
    ## GIT
    ###################################
    "git")
        if [ "$#" -lt 2 ]; then
            echo "Missing git url"
            exit 1
        fi
        git clone --recursive "$2" "$CODE_DIR"
        ;;
esac

touch -- "$CODE_DIR/.gitkeep"
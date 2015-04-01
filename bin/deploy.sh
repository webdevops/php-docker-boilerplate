#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

#######################################
## Checks
#######################################

sectionHeader "Checking TYPO3 installation ..."

if [ ! -d "$CODE_DIR/fileadmin" -o ! -d "$CODE_DIR/typo3conf/ext/" ]; then
    errorMsg "Either $CODE_DIR/fileadmin or $CODE_DIR/typo3conf/ext/ doesn't exists"
    exit 1
fi

#######################################
## Composer
#######################################

sectionHeader "Checking for composer.json ..."

if [ -f "$CODE_DIR/composer.json" ]; then
    # Install composer
    execInDir "$CODE_DIR" "composer install --no-dev --no-interaction"
fi

#######################################
## Bower
#######################################

sectionHeader "Checking for bower.json ..."

find "$CODE_DIR/fileadmin" "$CODE_DIR/typo3conf/ext/" -type f -name 'bower.json' | while read FILE; do
    BOWER_JSON_DIR=$(dirname $($READLINK -f "$FILE"))

    execInDir "$BOWER_JSON_DIR" "bower install --silent"
done


#######################################
## NPM
#######################################

sectionHeader "Checking for package.json (npm) ..."

find "$CODE_DIR/fileadmin" "$CODE_DIR/typo3conf/ext/" -type f -name 'package.json' | while read FILE; do
    PACKAGE_JSON_DIR=$(dirname $($READLINK -f "$FILE"))

    if [ ! -d "$PACKAGE_JSON_DIR/node_modules/" -a -n "`which npm-cache`" ]; then
        # Install via npm-cache
        execInDir "$PACKAGE_JSON_DIR" "npm-cache install"
    else
        # Install via npm
        execInDir "$PACKAGE_JSON_DIR" "npm install"
    fi
done

#######################################
## Gulp
#######################################

sectionHeader "Checking for gulpfile.js in T3 Root ..."

if [ -f "$CODE_DIR\gulpfile.js" ]; then
    execInDir "$CODE_DIR" "gulp deploy"
fi

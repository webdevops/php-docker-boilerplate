#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

function excludeFilter {
    cat | grep -v -E -e '(/typo3/|/typo3_src|/fileadmin/|/typo3temp/|/uploads/|/Packages/|/Data/|/vendor/)'
}

#######################################
## Composer
#######################################

sectionHeader "Checking for composer.json ..."

find "$CODE_DIR" -type f -name 'composer.json' | excludeFilter | while read FILE; do
    COMPOSER_JSON_DIR=$(dirname $($READLINK -f "$FILE"))

    execInDir "$COMPOSER_JSON_DIR" "composer install --no-dev --no-interaction"
done


#######################################
## Bower
#######################################

sectionHeader "Checking for bower.json ..."

find "$CODE_DIR" -type f -name 'bower.json' | excludeFilter | while read FILE; do
    BOWER_JSON_DIR=$(dirname $($READLINK -f "$FILE"))

    execInDir "$BOWER_JSON_DIR" "bower install --silent"
done


#######################################
## NPM
#######################################

sectionHeader "Checking for package.json (npm) ..."

find "$CODE_DIR" -type f -name 'package.json' | excludeFilter | while read FILE; do
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

find "$CODE_DIR" -type f -name 'package.json' | excludeFilter | while read FILE; do
    GULPFILE_DIR=$(dirname $($READLINK -f "$FILE"))

    execInDir "$GULPFILE_DIR" "gulp deploy"
done

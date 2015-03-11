#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.config.sh"

rm -f "$TYPO3_DIR/.gitkeep"
execInDir "$TYPO3_DIR" "composer create-project typo3/cms-base-distribution \"$TYPO3_DIR\""
execInDir "$TYPO3_DIR" "touch FIRST_INSTALL"
touch "$TYPO3_DIR/.gitkeep"
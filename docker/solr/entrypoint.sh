#!/bin/bash

if [ -n "$SOLR_STORAGE" ]; then
    rm -rf    /opt/solr/example/solr/typo3cores/data
    mkdir -p  "$SOLR_STORAGE"
    chmod 777 "$SOLR_STORAGE"
    ln -s     "$SOLR_STORAGE" /opt/solr/example/solr/typo3cores/data
fi

bash /core-create.sh

exec java -jar start.jar

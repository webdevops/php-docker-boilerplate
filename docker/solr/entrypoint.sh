#!/bin/bash


###################
# Move storage to storage container
###################
if [ -n "$SOLR_STORAGE" ]; then
    rm -rf    /opt/solr/example/solr/typo3cores/data
    mkdir -p  "$SOLR_STORAGE"
    chmod 777 "$SOLR_STORAGE"
    ln -s     "$SOLR_STORAGE" /opt/solr/example/solr/typo3cores/data
fi

###################
# Create solr data directories (on demand)
###################
grep -o "dataDir=\"[^'\"]*\"" /opt/solr/example/solr/solr.xml | sed -E 's/dataDir="(.+)"/\1/' | while read SOLR_CORE; do
    mkdir -p  "/opt/solr/example/solr/typo3cores/$SOLR_CORE"
    chmod 777 "/opt/solr/example/solr/typo3cores/$SOLR_CORE"
done


###################
# Run solr
###################
exec java -jar start.jar

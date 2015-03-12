#!/usr/bin/env bash

grep -o "dataDir=\"[^'\"]*\"" /opt/solr/example/solr/solr.xml | sed -E 's/dataDir="(.+)"/\1/' | while read SOLR_CORE; do
    mkdir     "/opt/solr/example/solr/typo3cores/$SOLR_CORE"
    chmod 777 "/opt/solr/example/solr/typo3cores/$SOLR_CORE"
done
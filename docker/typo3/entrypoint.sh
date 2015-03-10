#!/bin/bash

rm -rf /var/www/typo3temp/*
/bin/bash -l -c "$*"

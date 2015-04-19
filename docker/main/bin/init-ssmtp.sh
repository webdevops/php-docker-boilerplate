#!/usr/bin/env bash

#############################
## Init SSMTP
#############################

sed -i "s/mailhub=.*/mailhub=${MAIL_GATEWAY}/"        /etc/ssmtp/ssmtp.conf
sed -i "s/#FromLineOverride=.*/FromLineOverride=YES/" /etc/ssmtp/ssmtp.conf

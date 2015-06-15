#!/bin/bash
set -e

#############################
## USER
#############################

mkdir -p "${FTP_PATH}"

if ( id "${FTP_USER}" ); then
  echo "User ${FTP_USER} already exists"
else
  echo "Creating user and group ${FTP_USER}"
  ENC_PASS=$(perl -e 'print crypt($ARGV[0], "password")' "${FTP_PASSWORD}")
  groupadd -g "${EFFECTIVE_GID}" "${FTP_USER}"
  useradd -d "${FTP_PATH}" -m -p "${ENC_PASS}" -u "${EFFECTIVE_UID}" --gid "${FTP_USER}" -s /bin/sh "${FTP_USER}"
fi

#############################
## COMMAND
#############################

case "$1" in

    ## Supervisord (start daemons)
    supervisord)
        ## Register IP
        ETH0_IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
        mkdir -p /data/dns/
        chmod 777 /data/dns/
        echo "${ETH0_IP}"             > /data/dns/ftp.ip
        echo "${ETH0_IP}   ftp ftp_1" > /data/dns/ftp.hosts

        ## Start services
        exec supervisord
        ;;

    ## All other commands
    *)
        exec "$@"
        ;;
esac

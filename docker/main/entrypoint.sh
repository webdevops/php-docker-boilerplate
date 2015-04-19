#!/bin/bash
set -e

## Init system
source /opt/docker/init-system.sh

## Init MySQL (client)
source /opt/docker/init-mysql.sh

## Init SSMTP
source /opt/docker/init-ssmtp.sh

## Init SSMTP
source /opt/docker/init-php.sh

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
        echo "${ETH0_IP}"               > /data/dns/main.ip
        echo "${ETH0_IP}   main main_1" > /data/dns/main.hosts

        ## Start services
        exec supervisord
        ;;

    ## Root shell
    root)
        if [ "$#" -eq 1 ]; then
            ## No command, fall back to shell
            exec bash
        else
            ## Exec root command
            shift
            exec "$@"
        fi
        ;;

    ## All other commands
    *)
        ## Set home dir (workaround)
        export HOME=/home/
        ## Execute cmd
        sudo -E -u www-data "$@"
        ;;
esac

#!/bin/bash
set -e

bash /opt/docker/bin/provision.sh entrypoint

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

    ## Defined cli script
    cli)
        if [ -n "${CLI_SCRIPT}" ]; then
            shift
            exec sudo -H -E -u "${CLI_USER}" ${CLI_SCRIPT} "$@"
        else
            echo "[ERROR] No CLI_SCRIPT in docker-env.yml defined"
            exit 1
        fi
        ;;

    ## All other commands
    *)
        ## Execute cmd
        exec sudo -H -E -u "${CLI_USER}" "$@"
        ;;
esac

#!/usr/bin/env bash

sleep 5

## backup original resolv.conf
if [ ! -f "/opt/docker/.resolv.conf" ]; then
    ## backup original file
    cp /etc/resolv.conf /opt/docker/.resolv.conf

    ## Copy resolv.conf for dnsmasq (default resolver)
    cp /etc/resolv.conf /var/run/dnsmasq/resolv.conf
fi

## Restore original resolvconf
function restore_resolvconf() {
    ## restore original resolv.conf
    cp /opt/docker/.resolv.conf /etc/resolv.conf
}

## Start and configure dnsmasq
function dnsmasq_start() {
    restore_resolvconf

    ## clear dns file
    echo > /etc/dnsmasq.d/development

    ## add IP for each domain (wildcard!)
    for DOMAIN in $DNS_DOMAIN; do
        echo "address=/${DOMAIN}/${1}" >> /etc/dnsmasq.d/development
    done

    ## (re)start dnsmasq as DNS server
    service dnsmasq restart

    ## set dnsmasq to main nameserver
    echo "nameserver 127.0.0.1" > /etc/resolv.conf

    ## wait for 6 hours
    sleep 21600
}

## Fetch IP from services
if [ -f "/data/dns/httpd.ip" ]; then
    ## Found HTTPD
    HTTPD_IP=$(cat /data/dns/httpd.ip)
    dnsmasq_start "${HTTPD_IP}"
elif [ -f "/data/dns/nginx.ip" ]; then
    ## Found NGINX
    NGINX_IP=$(cat /data/dns/nginx.ip)
    dnsmasq_start "${NGINX_IP}"
else
    ## Found nothing, restore original resolvconf
    restore_resolvconf
    sleep 15
fi

exit 0

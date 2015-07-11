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
    echo "[dnsmasq] Found Webserver IP: $1"

    restore_resolvconf

    ## clear dns file
    echo > /etc/dnsmasq.d/development

    ## add IP for each domain (wildcard!)
    for DOMAIN in $DNS_DOMAIN; do
        echo "address=/${DOMAIN}/${1}" >> /etc/dnsmasq.d/development
    done

    ## set forward servers
    cat /opt/docker/.resolv.conf | grep nameserver | sed 's/nameserver /server=/' > /etc/dnsmasq.d/forward

    ## (re)start dnsmasq as DNS server
    service dnsmasq restart

    ## set dnsmasq to main nameserver
    echo "nameserver 127.0.0.1" > /etc/resolv.conf

    ## wait for 10 hours
    sleep 10h
}

## Fetch IP from services
if [ -f "/data/dns/web.ip" ]; then
    ## Found WEB
    dnsmasq_start "$(cat /data/dns/web.ip)"
elif [ -f "/data/dns/httpd.ip" ]; then
    ## Found HTTPD (fallback)
    dnsmasq_start "$(cat /data/dns/httpd.ip)"
elif [ -f "/data/dns/nginx.ip" ]; then
    ## Found NGINX (fallback)
    dnsmasq_start "$(cat /data/dns/nginx.ip)"
else
    ## Found nothing, restore original resolvconf
    restore_resolvconf
    sleep 15
fi

exit 0

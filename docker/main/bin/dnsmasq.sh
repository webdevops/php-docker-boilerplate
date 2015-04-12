#!/usr/bin/env bash

sleep 5

## backup original resolv.conf
if [ ! -f "/opt/docker/.resolv.conf" ]; then
    cp /etc/resolv.conf /opt/docker/.resolv.conf
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

    echo > /etc/dnsmasq.d/development

    for DOMAIN in $DNS_DOMAIN; do
        echo "address=/${DOMAIN}/${1}" >> /etc/dnsmasq.d/development
    done

    service dnsmasq restart

    echo "nameserver 127.0.0.1" > /etc/resolv.conf

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

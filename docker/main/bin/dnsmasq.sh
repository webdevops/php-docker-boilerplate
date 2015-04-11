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
    echo "address=/vm.dev/${1}" >> /etc/dnsmasq.d/development
    echo "address=/vm/${1}" >> /etc/dnsmasq.d/development
    service dnsmasq restart

    echo "nameserver 127.0.0.1" > /etc/resolv.conf

    sleep 900000
}

## Register in consul (if available)
if [ -n "${CONSUL_PORT_8500_TCP_ADDR}" ]; then
    HTTPD_IP=$(dig @${CONSUL_PORT_8500_TCP_ADDR} +short httpd.service.consul | head -1)
    NGINX_IP=$(dig @${CONSUL_PORT_8500_TCP_ADDR} +short nginx.service.consul | head -1)


    if [ -n "$HTTPD_IP" ]; then
        ## Found HTTPD
        dnsmasq_start "${HTTPD_IP}"
    elif [ -n "$NGINX_IP" ]; then
        ## Found NGINX
        dnsmasq_start "${NGINX_IP}"
    else
        ## Found nothing, restore original resolvconf
        restore_resolvconf
        sleep 15
    fi
else
    sleep 120
fi

exit 0

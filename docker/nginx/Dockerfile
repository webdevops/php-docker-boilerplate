FROM dockerfile/nginx

ADD vhost.conf /etc/nginx/sites-enabled/default
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
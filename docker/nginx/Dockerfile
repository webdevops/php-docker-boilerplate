FROM dockerfile/nginx

ADD conf/vhost.conf /etc/nginx/sites-enabled/default
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
FROM dockerfile/nginx

ADD conf/vhost.conf /etc/nginx/sites-available/default.tpl
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
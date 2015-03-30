FROM httpd:2.4

ENV DEBIAN_FRONTEND noninteractive

ADD conf/vhost.conf /usr/local/apache2/conf/.docker-vhost.conf.original
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["httpd"]
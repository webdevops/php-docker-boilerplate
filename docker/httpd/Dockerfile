FROM httpd:2.4

RUN apt-get update && apt-get install -y net-tools curl

ADD conf/vhost.conf /usr/local/apache2/conf/.docker-vhost.conf.original
ADD entrypoint.sh /entrypoint.sh

EXPOSE 80
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["httpd"]

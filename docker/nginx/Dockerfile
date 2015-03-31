FROM nginx

ADD conf/vhost.conf /opt/docker/vhost.conf
ADD entrypoint.sh   /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx"]
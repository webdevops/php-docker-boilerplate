FROM nginx

ADD conf/vhost.conf /opt/docker/vhost.conf
ADD entrypoint.sh   /entrypoint.sh

EXPOSE 80
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx"]

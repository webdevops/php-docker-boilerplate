FROM nginx

RUN apt-get update && apt-get install -y net-tools

ADD conf/vhost.conf /opt/docker/vhost.conf
ADD ssl/*           /etc/nginx/ssl/
ADD entrypoint.sh   /entrypoint.sh

EXPOSE 80
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx"]

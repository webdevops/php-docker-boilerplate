FROM ubuntu:14.04

COPY conf/php.ini          /etc/php5/mods-available/docker-boilerplate.ini
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/locale.conf      /opt/docker/locale.conf
COPY bin/*                 /opt/docker/
ADD entrypoint.sh          /entrypoint.sh

RUN bash /opt/docker/install.sh

EXPOSE 9000

VOLUME /docker/
WORKDIR /docker/code/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]

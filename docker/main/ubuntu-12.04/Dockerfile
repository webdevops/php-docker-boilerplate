FROM ubuntu:12.04

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/locale.conf      /opt/docker/locale.conf
COPY bin/*                 /opt/docker/
ADD entrypoint.sh          /entrypoint.sh

RUN bash /opt/docker/install.sh
RUN bash /opt/docker/customization.sh

COPY conf/php.ini          /etc/php5/mods-available/docker-boilerplate.ini

EXPOSE 9000

VOLUME /docker/
WORKDIR /docker/code/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]

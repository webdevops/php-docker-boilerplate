FROM ubuntu:14.04

COPY conf/php.ini          /etc/php5/mods-available/typo3.ini
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/locale.conf      /opt/docker/locale.conf
COPY bin/*                 /opt/docker/

RUN bash /opt/docker/install.sh

ADD ./htdocs /var/www/htdocs

EXPOSE 9000

VOLUME /code/
WORKDIR /code/

CMD ["/usr/bin/supervisord"]

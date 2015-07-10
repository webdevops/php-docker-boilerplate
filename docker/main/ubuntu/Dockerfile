#+++++++++++++++++++++++++++
# Ubuntu PHP Docker container
#
# ubuntu:12.04 - PHP 5.3, LTS (precise)
# ubuntu:14.04 - PHP 5.5, LTS (trusty)
# ubuntu:15.10 - PHP 5.6 (vivid)
# ubuntu:15.10 - PHP 5.6, LTS (wily)
#
#+++++++++++++++++++++++++++

FROM ubuntu:14.04

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

##
# Bootstrap
##

COPY conf/locale.conf      /opt/docker/locale.conf
COPY bin/bootstrap.sh      /opt/docker/bin/bootstrap.sh
COPY bin/provision.sh      /opt/docker/bin/provision.sh
COPY bin/logwatch.sh       /opt/docker/bin/logwatch.sh
COPY bin/dnsmasq.sh        /opt/docker/bin/dnsmasq.sh
COPY provision/*           /opt/docker/provision/

RUN bash /opt/docker/bin/bootstrap.sh
RUN bash /opt/docker/bin/provision.sh bootstrap

##
# Customization
##

COPY bin/customization.sh  /opt/docker/bin/customization.sh
RUN bash /opt/docker/bin/customization.sh

##
# Config
##

COPY entrypoint.sh         /entrypoint.sh
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/php.ini          /etc/php5/mods-available/docker-boilerplate.ini

EXPOSE 9000

VOLUME /docker/
WORKDIR /docker/code/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]

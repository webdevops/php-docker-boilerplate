#+++++++++++++++++++++++++++
# Ubuntu PHP Docker container
#
# ubuntu:12.04 - PHP 5.3, LTS (precise)
# ubuntu:14.04 - PHP 5.5, LTS (trusty)
# ubuntu:15.10 - PHP 5.6 (vivid)
# ubuntu:15.10 - PHP 5.6, LTS (wily)
#
#+++++++++++++++++++++++++++

FROM centos:7

ENV PATH /opt/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/library

##
# Bootstrap
##

COPY conf/locale.conf      /opt/docker/locale.conf
COPY bin/bootstrap.sh      /opt/docker/bin/bootstrap.sh
COPY bin/provision.sh      /opt/docker/bin/provision.sh
COPY bin/logwatch.sh       /opt/docker/bin/logwatch.sh
COPY bin/dnsmasq.sh        /opt/docker/bin/dnsmasq.sh
COPY provision             /opt/docker/provision/

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
COPY conf/supervisord.conf /etc/supervisord.d/supervisord.ini
COPY conf/php.ini          /etc/php.d/zzz-docker-boilerplate.ini

EXPOSE 9000

VOLUME /docker/
WORKDIR /docker/code/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord"]

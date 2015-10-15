#++++++++++++++++++++++++++++++++++++++
# VSFTP Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   ubuntu:14.04 - PHP 5.5, LTS (trusty)
#                  https://hub.docker.com/r/library/ubuntu/
#
#++++++++++++++++++++++++++++++++++++++

FROM ubuntu:14.04

ENV VSFTP_USER     dev
ENV VSFTP_PASSWORD dev
ENV VSFTP_PATH     /data/ftp/

RUN apt-get update && \
    apt-get install -y vsftpd supervisor

RUN mkdir -p /var/run/vsftpd/empty
RUN mkdir -p /var/log/supervisor

COPY entrypoint.sh         /entrypoint.sh
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY conf/vsftpd.conf      /etc/vsftpd.conf

RUN mkdir -p /data/ftp/

VOLUME "/data/ftp/"

EXPOSE 20
EXPOSE 21
EXPOSE 12020
EXPOSE 12021
EXPOSE 12022
EXPOSE 12023
EXPOSE 12024
EXPOSE 12025

ENTRYPOINT ["/entrypoint.sh"]

CMD ["supervisord"]

#++++++++++++++++++++++++++++++++++++++
# Storage Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   ubuntu:14.04 - PHP 5.5, LTS (trusty)
#                  https://hub.docker.com/r/library/ubuntu/
#
#++++++++++++++++++++++++++++++++++++++

FROM ubuntu:14.04

ADD entrypoint.sh   /entrypoint.sh

RUN mkdir -p /data
RUN mkdir -p /data/dns/
RUN mkdir -p /data/shared/
RUN chmod -R 777 /data

VOLUME "/data"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["noop"]

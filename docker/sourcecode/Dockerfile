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

RUN mkdir -p /docker/code/
RUN chmod -R 777 /docker/code/

COPY code /docker/code/

VOLUME "/docker/code/"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["noop"]

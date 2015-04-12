FROM ubuntu:14.04

ADD entrypoint.sh   /entrypoint.sh

RUN mkdir -p /data
RUN mkdir -p /data/dns/
RUN chmod -R 777 /data

VOLUME "/data"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["none"]

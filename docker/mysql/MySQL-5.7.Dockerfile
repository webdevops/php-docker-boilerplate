#++++++++++++++++++++++++++++++++++++++
# MySQL Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   mysql   - official MySQL from Oracle
#             https://hub.docker.com/r/library/mysql/
#
#++++++++++++++++++++++++++++++++++++++

FROM mysql:5.7

ADD conf/mysql-docker.cnf /etc/mysql/conf.d/z99-docker.cnf
RUN chown mysql:mysql /etc/mysql/conf.d/z99-docker.cnf \
    && chmod 0644 /etc/mysql/conf.d/z99-docker.cnf

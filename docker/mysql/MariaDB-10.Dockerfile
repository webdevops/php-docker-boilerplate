#++++++++++++++++++++++++++++++++++++++
# MySQL Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   mariadb - MariaDB (MySQL fork) from MariaDB Foundation
#             https://hub.docker.com/r/library/mariadb/
#
#++++++++++++++++++++++++++++++++++++++

FROM mariadb:10

ADD conf/mysql-docker.cnf /etc/mysql/conf.d/z99-docker.cnf

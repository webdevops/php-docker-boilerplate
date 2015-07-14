#++++++++++++++++++++++++++++++++++++++
# MySQL Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   mysql   - official MySQL from Oracle
#             https://registry.hub.docker.com/u/library/mysql/
#
#   mariadb - MariaDB (MySQL fork) from MariaDB Foundation
#             https://registry.hub.docker.com/u/library/mariadb/
#
#   percona - PerconaDB  (MySQL fork) from Percona
#             https://registry.hub.docker.com/u/library/percona/
#
#++++++++++++++++++++++++++++++++++++++

FROM mysql:5.5

ADD conf/mysql-docker.cnf /etc/mysql/conf.d/z99-docker.cnf

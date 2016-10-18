#++++++++++++++++++++++++++++++++++++++
# MySQL Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   percona - PerconaDB  (MySQL fork) from Percona
#             https://hub.docker.com/r/library/percona/
#
#++++++++++++++++++++++++++++++++++++++

FROM percona:5.7

ADD conf/mysql-docker.cnf /etc/mysql/conf.d/z99-docker.cnf

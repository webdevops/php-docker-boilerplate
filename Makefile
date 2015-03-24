BACKUP_DIR = backup
MYSQL_BACKUP_FILE = database.sql.bz2
SOLR_BACKUP_FILE = solr.tar.bz2

all: deploy

#############################
# Create new project
#############################

create-cms-project:
	bash bin/create-project.sh cms

create-neos-project:
	bash bin/create-project.sh neos

#############################
# MySQL
#############################

mysql-backup:
	test -d "$(BACKUP_DIR)" && { docker-compose run --rm typo3 mysqldump --opt --all-databases | bzip2 > "$(BACKUP_DIR)/$(MYSQL_BACKUP_FILE)"; }

mysql-restore:
	test -s "$(BACKUP_DIR)/$(MYSQL_BACKUP_FILE)" && { bzcat "$(BACKUP_DIR)/$(MYSQL_BACKUP_FILE)" | docker-compose run --rm typo3 mysql; }

#############################
# Solr
#############################

solr-backup:
	test -d "$(BACKUP_DIR)"
	docker-compose stop solr
	rm -f "$(BACKUP_DIR)/$(SOLR_BACKUP_FILE)"
	docker-compose run --rm --no-deps typo3 tar jcf "/var/www/$(BACKUP_DIR)/$(SOLR_BACKUP_FILE)" /data/solr/
	docker-compose start solr

solr-restore:
	test -s "$(BACKUP_DIR)/$(SOLR_BACKUP_FILE)"
	docker-compose stop solr
	docker-compose run --rm --no-deps typo3 'rm -rf /data/solr/* && mkdir -p /data/solr/'
	docker-compose run --rm --no-deps typo3 tar jxf "/var/www/$(BACKUP_DIR)/$(SOLR_BACKUP_FILE)" -C /
	docker-compose start solr

#############################
# General
#############################

backup:  mysql-backup  solr-backup
restore: mysql-restore solr-restore

deploy:
	bash bin/deploy.sh

clean:
	test -d htdocs/typo3temp && { rm -rf htdocs/typo3temp/*; }

#############################
# TYPO3
#############################

scheduler:
	docker-compose run --rm typo3 typo3/cli_dispatch.phpsh scheduler
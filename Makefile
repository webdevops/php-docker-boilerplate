BACKUP_DIR = backup
MYSQL_BACKUP_FILE = database.sql.bz2

all: deploy

clean:
	test -d htdocs/typo3temp && { rm -rf htdocs/typo3temp/*; }

mysql-backup:
	test -d "$(BACKUP_DIR)" && { docker-compose run typo3 mysqldump --opt typo3 | bzip2 > "$(BACKUP_DIR)/$(MYSQL_BACKUP_FILE)"; }

mysql-restore:
	test -s "$(BACKUP_DIR)/$(MYSQL_BACKUP_FILE)" && { bzcat "$(BACKUP_DIR)/$(MYSQL_BACKUP_FILE)" | docker-compose run typo3 mysql typo3; }

deploy:
	bash bin/deploy.sh

create-cms-project:
	bash bin/create-cms-project.sh

scheduler:
	docker-compose run --rm typo3 typo3/cli_dispatch.phpsh scheduler
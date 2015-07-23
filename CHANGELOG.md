PHP Docker Boilerplate Changelog
==================================

4.0.0 - UPCOMING
-----------------------
- Seperated TYPO3 Docker Boilerplate and PHP Docker Boilerplate
- Switched to Ansible provisioning (playbook)
- Added multiple Ubuntu versions
- Added CentOS
- Added Ubuntu with HHVM
- Added development/production context
- Added blackfire.io
- Added possiblity to disable Xdebug and Blackfire
- Improved provisioning
- Refactored layout
- Added prebuilt Docker images

3.5.0 - 2015-06-23
-----------------------
- Added `ftp` container (with vsftpd)
- Added `postgres` container (with PostgreSQL)
- Enabled php module `mcrypt` by default
- Improved documentation

3.4.0 - 2015-06-15
-------------------------------------
- Renamed `PHP_UID` and `PHP_GID` to `EFFECTIVE_UID` and `EFFECTIVE_GID`
- Set Apache HTTPd and Nginx UID to `EFFECTIVE_UID` and `EFFECTIVE_GID`
- Renamed `make deploy` to `make build` (was confusing)
- Fixed MySQL default charset (set to utf8)
- Added `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_ROOT_USER`, `MYSQL_ROOT_PASSWORD` and `MYSQL_DATABASE` for nginx/apache/php-fpm
- Improved customization of `php.ini`
- Improved documentation
- Added php memcache and memcached

3.3.1 - 2015-05-11
-------------------------------------
- Fixed ssl certificate

3.3.0 - 2015-05-09 - t3cs2015 release
-------------------------------------
- Fixed `make mysql-backup`
- Added `docker/main/bin/customization.sh` for easy customization and faster docker rebuilding
- Added `CLI_USER` for customizable user in `docker-env.yml` (for `CLI_SCRIPT`)
- Added ssl (SHA2) for nginx and apache HTTPd
- Added `/data/cache` for application cache storage (inside `storage` container)
- Improved `make deploy` (supports all other frameworks now, not only TYPO3)
- Fixed $HOME variable for shell and cli entrypoint targets (sudo issue)
- Improved `docker-env.yml` layout with some examples

3.2.0 - 2015-04-26
------------------
- Added `mailcatcher` container
- Added `cli` target for entrypoint in `main` container
- Smaller improvements

3.0.0 - 2015-04-19
------------------
- Added customizeable `PHP_UID` and `PHP_GID` (for www-data user) in `docker-env.yml`
- Added `PHP_TIMEZONE` in `docker-env.yml`
- Added advanced logging for php (see docker-compose logs for access, slowlog and errorlog)
- Added capability for PHP-FPM to trace for slowlog
- Added possibility to reach webserver from php-container (with dnsmasq) eg. for indexing tasks
- Readded xdebug
- Improved configuration
- Improved database backup
- Improved container layout

2.1.0 - 2015-04-01
------------------
- Added customizeable `DOCUMENT_INDEX` in `docker-env.yml`

2.0.0 - 2015-03-31
------------------
- Added customizeable `DOCUMENT_ROOT` in `docker-env.yml`
- Switched to official nginx
- Moved `/code/` to `/docker`
- Fixed some bugs

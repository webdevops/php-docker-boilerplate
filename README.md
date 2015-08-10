# Dockerized PHP web project boilerplate

[![latest v4.0.0](https://img.shields.io/badge/latest-v4.0.0-green.svg?style=flat)](https://github.com/mblaschke/php-docker-boilerplate/releases/tag/4.0.0)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/mblaschke/php-docker-boilerplate.svg)](http://isitmaintained.com/project/mblaschke/php-docker-boilerplate "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/mblaschke/php-docker-boilerplate.svg)](http://isitmaintained.com/project/mblaschke/php-docker-boilerplate "Percentage of issues still open")

This is an easy customizable docker boilerplate for any PHP based projects like _Symfony Framework_, _CakePHP_, _Yii_ and many other frameworks or applications.

Supports:

- Nginx or Apache HTTPd
- PHP-FPM (with Xdebug)
- MySQL, MariaDB or PerconaDB
- PostgreSQL
- Solr (disabled, without configuration)
- Elasticsearch (disabled, without configuration)
- Redis (disabled)
- Memcached (disabled)
- Mailcatcher (if no mail sandbox is used, eg. [Vagrant Development VM](https://github.com/mblaschke/vagrant-development))
- FTP server (vsftpd)
- maybe more later...

This Docker boilerplate based on the best practises and don't use too much magic.
Configuration of each docker container is available in the `docker/` directory - feel free to customize.

This boilerplate can also be used for any other web project eg. Symfony, CakePHP, Magento and more.
Just customize the makefile for your needs

Warning: There may be issues when using it in production - if you have any success stories please contact me.

You can use my [Vagrant Development VM](https://github.com/mblaschke/vagrant-development) for this Docker boilerplate, eg. for easy creating new boilerplate installations with an easy shell command: `ct docker:create directory`

## Table of contents

- [Installation and requirements](/documentation/INSTALL.md)
- [Updating docker boilerplate](/documentation/UPDATE.md)
- [Customizing](/documentation/CUSTOMIZE.md)
- [Services (Webserver, MySQL... Ports, Users, Passwords)](/documentation/SERVICES.md)
- [Docker Quickstart](/documentation/DOCKER-QUICKSTART.md)
- [Run your project](/documentation/DOCKER-STARTUP.md)
- [Container detail info](/documentation/DOCKER-INFO.md)
- [Troubleshooting](/documentation/TROUBLESHOOTING.md)
- [Changelog](/CHANGELOG.md)

## Credits

This Docker layout is based on https://github.com/denderello/symfony-docker-example/

Thanks for support, ideas and issues ...
- [Ingo Pfennigstorf](https://github.com/ipf)
- [Florian Tatzel](https://github.com/PanadeEdu)
- [Josef Florian Glatz](https://github.com/jousch)
- [Ingo Müller](https://github.com/IngoMueller)
- [Benjamin Rau](https://twitter.com/benjamin_rau)
- [Philipp Kitzberger](https://github.com/Kitzberger)

Thanks to [cron IT GmbH](http://www.cron.eu/) for inspiration.

Did I forget anyone? Send me a tweet or create pull request!

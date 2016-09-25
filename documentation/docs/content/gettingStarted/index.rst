===============
Getting Started
===============

------------
Requirements
------------

* Docker host (eg. Vagrant Docker VM or dinghy)
* Docker compose

------------
Installation
------------

Clone the boilerplate and link or copy ``docker-compose.development.yml``

.. code-block:: bash

   git clone https://github.com/webdevops/php-docker-boilerplate.git project
   cd project
   cp docker-compose.development.yml docker-compose.yml

-----
Usage
-----

Startup containers and run the services:

.. code-block:: bash

   docker-compose up -d

------------------------------
Web access (dinghy http proxy)
------------------------------

If you're using dinghy docker](https://github.com/codekitchen/dinghy) you can access the services via

- Application: http://app.boilerplate.docker/
- Mailhog: http://mail.boilerplate.docker
- PHPMyAdmin: http://pma.boilerplate.docker
- Solr: http://solr.boilerplate.docker
- Elasticsearch: http://elasticsearch.boilerplate.docker

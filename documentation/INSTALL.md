[<-- Back to main section](../README.md)

# Installation

## Reqirements

- GNU/Linux with Docker (recommendation: Vagrant VM with Docker or native Linux with Docker)
- make
- [composer](https://getcomposer.org/)
- [docker-compose](https://github.com/docker/compose)

If you want to run a Docker VM make sure you're using VMware or Parallels Desktop because of
the much faster virtualisation (networking, disk access, shared folders) compared to VirtualBox.

There is also a [Vagrant VM for VirtualBox, VMware and Parallels](https://github.com/mblaschke/vagrant-development)
with a mailcatcher (Postfix with Dovecot, catches all outgoing mails).

For more convenience use [CliTools.phar](https://github.com/mblaschke/clitools) (will also run on native Linux, not only inside a Vagrant box)

## First startup

```bash
git clone https://github.com/mblaschke/TYPO3-docker-boilerplate.git projectname
```

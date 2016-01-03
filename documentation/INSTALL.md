[<-- Back to main section](../README.md)

# Installation

## Reqirements

- GNU/Linux with Docker (recommendation: Vagrant VM with Docker or native Linux with Docker)
- make
- [composer](https://getcomposer.org/)
- [docker-compose](https://github.com/docker/compose)

If you want to run a Docker VM make sure you're using VMware or Parallels Desktop because of
the much faster virtualisation (networking, disk access, shared folders) compared to VirtualBox.

There is also a [Vagrant VM for VirtualBox, VMware and Parallels](https://github.com/webdevops/vagrant-development)
with a mailcatcher (Postfix with Dovecot, catches all outgoing mails).

_Warning:_ Boot2docker ist not recommended because of slow/buggy file sharing between host and guest and there is no
convienient way to access the box with Samba or SSH.
This Docker boilerplate tries to avoid common anti-patterns like a Samba/SSH container because Boot2docker
isn't able to handle such tasks.

For more convenience use [CliTools.phar](https://github.com/webdevops/clitools) (will also run on native Linux, not only inside a Vagrant box)

## First startup

```bash
git clone --recursive https://github.com/webdevops/php-docker-boilerplate.git projectname

cd projectname

docker-compose up -d
```

## What is this ?

This set of ansible playbooks deploy various environment such as laravel / IBM MQ / VNC / Radius on CentOS7.x.

## Current status in Changing php70 to php71

- base.yml        - OK
- composer.yml    - not tested
- laravel.yml     - not tested
- lessmd.yml      - OK
- mariadb.yml     - not tested
- mfa.yml         - not tested
- mq-client.yml   - not tested
- mq-core.yml     - not tested
- mq-docker.yml   - not tested
- mq-explorer.yml - not tested
- mq-laravel.yml  - not tested
- mq-php-pecl.yml - not tested
- mq-server.yml   - not tested
- nginx.yml       - not tested
- php-fpm.yml     - not tested
- php.yml         - OK
- postgresql.yml  - not tested
- supervisor.yml  - not tested
- vnc.yml         - not tested
- xdebug.yml      - not tested

## Prerequisite

- Vagrant + VirtualBox VM running CentOS 7.3 with git and ansible 2.x.
- typical installation process could be :

```bash
mkdir XXXX
cd XXXXX
vagrant box add bento/centos-7.3 --provider virtualbox
vagrant init bento/centos-7.3 
vagrant up
vagrant ssh
sudo yum -y install git epel-release
sudo yum -y install ansible
```

## Quick start

```bash
$ git clone https://github.com/hotta/ansible-centos7.git
$ sudo rm -r /etc/ansible
$ sudo mv ansible-centos7 /etc/ansible
$ cd /etc/ansible/
$ cp hosts.example hosts
$ vi hosts
$ cd ../host_vars
$ cp localhost.yml.tmpl localhost.yml
$ vi localhost.yml 
$ cd
# to deploy laravel base environment for example
$ ansible-playbook /etc/ansible/jobs/laravel.yml
```

You may want to take a look at /etc/ansible/jobs to see what jobs are
available.

## Component's versions ( as of 2017/01/10 ).

- php-5.6.25 / php-7.0.14
- SQLite-3.7.17 / MariaDB-5.5.50 / PostgreSQL-9.5.5
- Laravel-5.3.23
- IBM MQ 8.0.0
- FreeRadius 3.0.4

## Dependencies in roles

- base
  - nginx
    - php
      - php-fpm
        - xdebug
      - composer
      - ( sqlite / mariadb / postgresql )
        - laravel
  - vnc
  - mq-core
    - mq-docker
    - mq-client
    - mq-server
    - mq-exploler
    - mq-php-pecl
      - mq-laravel
  - mfa

## Log directories

- /var/log/nginx
- /var/log/php-fpm/
- /var/www/laravel/storage/logs


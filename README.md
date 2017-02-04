## What is this ?

This set of ansible playbooks deploy various environment such as laravel / IBM MQ / VNC / Radius on CentOS7.x.

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
$ vi hosts (You may want to make some changes.)
$ cd host_vars
$ cp localhost.yml.tmpl localhost.yml
$ vi localhost.yml  (You may want to make some changes.)
$ cd
# to deploy laravel base environment for example
$ ansible-playbook /etc/ansible/jobs/laravel.yml
```

You may want to take a look at /etc/ansible/jobs to see what jobs are
available.

## Component's versions ( as of 2017/02/01 ).

- php-7.1.1
- SQLite-3.7.17 / MariaDB-5.5.50 / PostgreSQL-9.5.5
- Laravel-5.4.7
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


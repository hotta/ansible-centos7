## What is this ?

Ansible playbooks to build laravel-5.3 development environment on CentOS7.x.

## Prerequisite

- Vagrant + VirtualBox VM running CentOS 7.2.
- git and ansible 2.x.
- You may want to use https://github.com/hotta/vagrant-cent72-box.git .

## Quick start

```bash
$ git clone git@github.com:hotta/laravel-centos7.git
$ sudo rm -r /etc/ansible
$ sudo mv laravel-centos7 /etc/ansible
$ cd /etc/ansible/host_vars
$ cp localhost-tmpl.yml localhost.yml
$ vi localhost.yml 
$ cd
$ ansible-playbook /etc/ansible/jobs/laravel.yml
```

## Versions ( as of 2016/11/16 ).

- php-5.6.25 / php-7.0.13
- SQLite-3.7.17 / MariaDB-5.5.50 / PostgreSQL-9.5.4
- Laravel-5.3.23

## Dependencies in roles

- base
  - nginx
    - php
      - php-fpm
        - xdebug
      - composer
      - ( sqlite / mariadb / postgresql )
        - laravel

## Log directories

- /var/log/nginx
- /var/opt/remi/php70/log/php-fpm/
- /opt/remi/php56/root/var/log/php-fpm/
- /var/www/laravel/storage/logs

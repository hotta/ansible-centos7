## What is this ?

Ansible playbooks to build development environment using laravel on CentOS7.x.

## Prerequisite

- Vagrant + VirtualBox VM running CentOS 7.2.
- git and ansible 2.x.
- You may want to use https://github.com/hotta/vagrant-cent72-box.git .

## Quick start

```bash
$ git clone git@github.com:hotta/laravel-centos7.git
$ sudo rm -r /etc/ansible
$ sudo mv laravel-centos7 /etc/ansible
$ vi /etc/ansible/host_vars/localhost.yml
$ ansible-playbook /etc/ansible/jobs/laravel.yml
```

## Combination of each software versions ( as of 2016/09/07 ).

- php-5.6.25
- MariaDB-5.5.50
- Laravel-5.2.45(tag points to 5.2.31)

## Dependencies in roles

- base
  - nginx
    - php
      - php-fpm
        - xdebug
      - composer
      - ( mariadb / postgresql )
        - laravel

## Log directories

- /var/log/nginx
- /var/opt/remi/php70/log/php-fpm/
- /opt/remi/php56/root/var/log/php-fpm/
- /var/www/laravel/storage/logs

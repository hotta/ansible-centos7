## What is this ?

Ansible playbooks to deploy Laravel development environment optimized for Japanese users.

## Prerequisite

- Vagrant + VirtualBox VM running CentOS 7.2.
- You may want to use https://github.com/hotta/vagrant-cent72-box.git .

## Yum repositories will be installed:

- epel
- remi

## php version 

- php 5.6 will be installed as default.
- Move localhost entry to php70 section in /etc/ansible/hosts to use php-7.x.

## Constans definitions

- group_vars/all          - Common constants 
- host_vars/localhost.yml - Host specific definitions
  - Locale-dependent settings (optimized for use in Japan)
  - Database settings (default sqlite)
  - You should change values following:
    - LARAVEL_SERVER_NAME (will be used as a VirtualHost name)
    - LARAVEL_IP_ADDRESS (config.vm.network value in your Vagrantfile)

## Dependencies in roles

- base
  - nginx
    - php
      - php-fpm
        - xdebug
      - composer
        - laravel
      - postgresql

## Log directories

- /var/log/nginx
- /var/opt/remi/php70/log/php-fpm/
- /opt/remi/php56/root/var/log/php-fpm/
- /var/www/laravel/storage/logs

## What is this ?

Ansible playbooks to deploy Laravel development environment optimized for Japanese users.

## Prerequisite

- Vagrant + VirtualBox VM running CentOS 7.2.
- You may want to use https://github.com/hotta/vagrant-cent72-box.git .

## Yum repositories will be installed:

- epel
- remi

## Constans definitions

- group_vars/all          - Common constants 
- host_vars/localhost.yml - Host specific definitions
  - Locale-dependent settings (optimized for use in Japan)
  - Database settings (default postgresql)
  - You might have to change values following:
    - LARAVEL_SERVER_NAME (will be used as a VirtualHost name)
    - LARAVEL_IP_ADDRESS (config.vm.network value in your Vagrantfile)

## Dependencies in roles

- base
  - postgresql
  - nginx
    - php
      - php-fpm
      - composer
        - laravel

## Log directories

- /var/log/nginx
- /var/opt/remi/php70/log/php-fpm/
- /var/www/laravel/storage/logs

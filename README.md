## What is this ?

A set of ansible playbooks to deploy Laravel development environment.

## Prerequisite

Vagrant + VirtualBox VM running CentOS 7.2.

## Yum repositories will be installed:

- epel
- remi

## Constans definitions

- group_vars/all          - Common constants among all environment
- host_vars/localhost.yml - Host specific definitions
  - Locale-dependent settings (optimized for use in Japan)

## Dependencies in roles

- base
  - postgresql
  - nginx
    - php
      - composer
        - laravel

## Important log directories

- /var/log/nginx
- /var/opt/remi/php70/log/php-fpm/
- /var/www/laravel/storage/logs

## Remarks

- Though we adopt nginx+php-fpm combination, php70-php-fpm uses apache/apache as its effective user/group. Take care.

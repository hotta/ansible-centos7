## What is this ?

This set of ansible playbooks aims to deploy Laravel development environment.

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

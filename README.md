# What is this ?

This set of ansible playbooks aims to deploy development environment for Laravel using Vagrant + VirtualBox + CentOS7 + PHP7 automatically.

# Constans definitions

- group_vars/all          - Common constants among all environment
- host_vars/localhost.yml - Host specific definitions
  - Currently covers localhost only
  - Locale-dependent settings are here (optimized for use in Japan)

# Dependencies in roles

- base
  - postgresql
  - nginx
    - php
      - composer
        - laravel

# To run from scratch

```bash
d:\> git clone git@github.com:hotta/vagrant-cent72-box.git
d:\> rename vagrant-cent72-box laravel
d:\> cd laravel
d:\laravel> vagrant up
d:\laravel> vagrant ssh
- At first time, you have to login via password authentication due to bug on vagrant-1.8.5.
- Then do:
  $ chmod 600 .ssh/authorized_keys
$ cat /etc/system-release
CentOS Linux release 7.2.1511 (Core)
```

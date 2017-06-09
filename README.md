This set of ansible playbooks deploy various environment such as laravel / IBM MQ / Radius / WordPress etc. on CentOS7.x.

## Prerequisite(Test Environment)

- Vagrant + VirtualBox VM running CentOS 7.3 with git and ansible 2.x.
- typical installation process could be as follows:

```bash
mkdir XXXX
cd XXXXX
vagrant box add bento/centos-7.3 --provider virtualbox
vagrant init bento/centos-7.3 
vi Vagrantfile (See below.)
vagrant up
```
And then log in to the VM as user "vagrant".

### Sample Vagrantfile:

```Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"
  config.vm.network "private_network", ip: "192.168.56.2"
  config.vm.hostname = "example.local"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y install git epel-release
    sudo yum -y install ansible
  SHELL
end
```

## Prerequisite(Production Environment - AWS EC2 for example)

- Create EC2 instance from "CentOS 7 (x86_64) - with Updates HVM" AMI in AWS Marketplace 
- Log in to the instance as user "centos"
- sudo yum update
- sudo yum -y install git epel-release
- sudo yum -y install ansible

## Put this set of playbooks

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
```

## Building environment 

```bash
$ ansible-playbook /etc/ansible/jobs/JOB-NAME-YOU-WANT-TO-DEPLOY.yml
```

- for example, if you want to deploy laravel environment, run:

```bash
$ ansible-playbook /etc/ansible/jobs/laravel.yml
```

- You may find jobs you want at [/jobs/README.md](https://github.com/hotta/ansible-centos7/tree/master/jobs).

## Component's versions ( as of 2017/06/02 ).

- php-7.1.5
- SQLite-3.7.17 / MariaDB-5.5.50 / PostgreSQL-9.6.3
- Laravel-5.4.24
- IBM MQ 8.0.0
- FreeRadius 3.0.4
- WordPress 4.7.5
- Sphinx 1.6.2

## Dependencies in roles

- base
  - nginx
    - php
      - php-fpm
        - xdebug
      - composer
      - postgresql
        - laravel
          - supervisor
      - mariadb
        - wordpress
        - vuedo
  - vnc
  - mq-core
    - mq-docker
    - mq-client
    - mq-server
    - mq-exploler
    - mq-php-pecl
      - mq-laravel
  - mfa
  - ldap
  - lessmd
  - php-ext
  - sphinx
  - vnc

# What is this?

[GitBucket](https://github.com/gitbucket/gitbucket) is a GitHub-like git platform. 

# Install

Base environment follows https://github.com/hotta/ansible-centos7 .
Do some stuff until "Building environment" section, then run:

```
$ ansible-playbook jobs/gitbucket.yml
```
After that, gitbucket would be already running as a service.
You can control start/stop/restart gitbucket using systemctl command.

# Usage

- Visit http://localhost:8888
- Sign in as root / root

# Configuration

For detail information, visit https://github.com/gitbucket/gitbucket/wiki .

## Service environment

- configuration file : /etc/sysconfig/gitbucket
- Default settings are:
```
GITBUCKET_HOST=0.0.0.0
GITBUCKET_PORT=8888
GITBUCKET_USER=gitbucket
GITBUCKET_HOME=/var/lib/gitbucket
```

## Database

- Default to use internal H2 database.
- Configuration file : /var/lib/gitbucket/database.conf
```
db {
  url = "jdbc:h2:${DatabaseHome};MVCC=true"
  ...
}
```

### Changing database from H2 to postgresql(optional)

```
$ ansible playbook jobs/postgresql.yml
$ sudo -u postgres createdb gitbucket
$ sudo systemctl stop gitbucket
$ sudo su - gitbucket
$ cp database.conf database.conf.orig
$ vi database.conf
$ diff database.conf.orig database.conf
2,4c2,4
<   url = "jdbc:h2:${DatabaseHome};MVCC=true"
<   user = "sa"
<   password = "sa"
---
>   url = "jdbc:postgresql://localhost/gitbucket"
>   user = "postgres"
>   password = ""
$ exit
$ sudo systemctl start gitbucket
```

If you want to upgrade existing H2 database, See "Data migration" and "PostgreSQL" in https://github.com/gitbucket/gitbucket/wiki/External-database-configuration .

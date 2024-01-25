# 389-ds quick guide

## the environment around OS

This playbook supports multi-provider replication by default.
We assume there are two hosts to set up. 
(Though, greater than two hosts is not yet supported).
The both hosts have the same settings as follows:

```
$ tail -2 /etc/hosts
192.168.56.6    ldap1   ldap1.example.com
192.168.56.7    ldap2   ldap2.example.com
$ grep ^[BU] /etc/openldap/ldap.conf
BASE    dc=example,dc=com
URI     ldap://localhost
```

The IP addresses should be read according to your environment.

## Create inventory

First, create inventory file to specify which hosts are to be configured.

```
$ cat hosts.ds389.tmpl
[ds389]
supplier1 ansible_host=ldap1.example.com replicaId=2
supplier2 ansible_host=ldap2.example.com replicaId=1
$ cp hosts.ds389.tmpl hosts.ds389
$ vi hosts.ds389
```

The two ansible_hosts must be able to enter each other (or from ansible controller host) via SSH.

## Change default Settings if needed

Second, check variables involved with 389DS.

```
$ grep ^DS389 group_vars/all
(snip)
```

You can overwrite these values by creating group_vars/ds389.yml and putting entries you want to change in it. You may have to rewrite DS389_REPL_HOST{1,2}to at least match the hosts listed in hosts.ds389.

## Run the playbook

```
$ ansible-playbook jobs/389ds.yml -i hosts.ds389
```

## After deploying jobs/389ds.yml

To check if desired(specified) LDAP instance is up:

```
$ systemctl status dirsrv@localhost
```

where the "localhost" part of "dirsrv@localhost" is the instance name specified by DS389_INSTANCE_NAME which is defined in group_vars/all.

'/tmp/ds-template.txt' file should be created and be used to create the LDAP instance.

To connect the LDAP server by using software such as [Apache Directory Studio](https://directory.apache.org/studio/), use settings follows (by default):

| item                      | value                 |
|---------------------------|-------------------------------|
| Port No                   | 389 or 636            |
| Bind DN                   | cn=Directory Manager  |
| Bind password             | Directory_Manager_Password    |
| Base DN for configuration | cn=config             |
| Base DN for user data     | dc=example,dc=com     |

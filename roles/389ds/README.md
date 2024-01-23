# 389-ds quick guide

## Create inventory

This playbook supports multi-provider replication by default.
It requiers at least two hosts to be configured (Though, greater than two hosts is not yet supported).
First, create inventory file to specify which hosts are to be configured.

```
$ cat hosts.389ds.tmpl
[389ds]
replica1 ansible_host=192.168.56.6 replicaId=1
replica2 ansible_host=192.168.56.7 replicaId=2
$ cp hosts.389ds.tmpl hosts.389ds
$ vi hosts.389ds                # Change IP adresses if needed
```

The two ansible_hosts must be able to enter each other (or from ansible controller host) via SSH.
 
## Change default Settings if needed

Second, check variables involved with 389DS.

```
$ grep ^DS389 group_vars/all
DS389_FORCE_CREATE:     True    # Overwrite current instance every time !!
(snip)
```

You can overwrite these values by creating group_vars/389ds.yml and putting entries you want to change in it. You must rewrite DS389_REPL_IP1 / DS389_REPL_IP2 to at least match the IP addresses listed in hosts.389ds.

## Run the playbook

```
$ ansible-playbook jobs/389ds.yml -i hosts.389ds
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

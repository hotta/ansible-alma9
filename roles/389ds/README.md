# 389-ds quick guide

## Default Settings

You can overwrite these values by creating host_vars/localhost.yml and writing entries you want to change.

```
$ grep ^DS389 group_vars/all
DS389_FORCE_CREATE:     True    # Overwrite current instance every time !!
DS389_CONFIG:   999999999                   # general.defaults
DS389_FQDN:     "{{ PCA_HOSTNAME }}.{{ PCA_DOMAIN_SUFFIX }}"    # general.full_machine_name
DS389_INSTANCE_NAME:    'localhost'         # slapd.instance_name
DS389_ROOT_DN:  'cn=Directory Manager'      # slapd.root_dn = BIND DN
DS389_ROOT_PASSWORD:    'Directory_Manager_Password'    # slapd.root_password
DS389_SAMPLE_ENTRIES:   'yes'               # backend-userroot.sample_entries
DS389_SUFFIX:   "dc=example,dc=com"         # backend-userroot.suffix
DS389_SERVICE_NAME:     "dirsrv@{{ DS389_INSTANCE_NAME }}"
```

## After deploying jobs/389ds.yml

'/tmp/ds-template.txt' will be created and used to create the LDAP instance.

To check if desired(specified) instance is up:

```
$ systemctl status dirsrv@localhost
● dirsrv@localhost.service - 389 Directory Server localhost.
     Loaded: loaded (/usr/lib/systemd/system/dirsrv@.service; enabled; preset: disabled)
    Drop-In: /usr/lib/systemd/system/dirsrv@.service.d
             └─custom.conf
     Active: active (running) since Thu 2023-09-21 14:21:45 JST; 2s ago
    Process: 9498 ExecStartPre=/usr/libexec/dirsrv/ds_systemd_ask_password_acl /etc/dirsrv/slapd-localhost/dse.ldif (code=exited, status=0/SUCCESS)
    Process: 9503 ExecStartPre=/usr/libexec/dirsrv/ds_selinux_restorecon.sh /etc/dirsrv/slapd-localhost/dse.ldif (code=exited, status=0/SUCCESS)
   Main PID: 9509 (ns-slapd)
     Status: "slapd started: Ready to process requests"
      Tasks: 29 (limit: 11051)
     Memory: 57.5M
        CPU: 1.796s
     CGroup: /system.slice/system-dirsrv.slice/dirsrv@localhost.service
             └─9509 /usr/sbin/ns-slapd -D /etc/dirsrv/slapd-localhost -i /run/dirsrv/slapd-localhost.pid
```

where the "localhost" part of "dirsrv@localhost" is the instance name specified by DS389_INSTANCE_NAME as described above.


To connect the LDAP server by using software such as [Apache Directory Studio](https://directory.apache.org/studio/), use settings follows:

| item                      | value                 |
|---------------------------|-------------------------------|
| Port No                   | 389                   |
| Bind DN                   | cn=Directory Manager  |
| Bind password             | Directory_Manager_Password    |
| Base DN for configuration | cn=config             |
| Base DN for user data     | dc=example,dc=com     |

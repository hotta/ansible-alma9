# Activating LDAP Auth


Up to RHEL7, authconfig was using as a configuration tool for authentication linkage.  As it has been deprecated since RHEL8, authselect is providing as a successor. Also,  nss-pam-ldapd was using when using LDAP for external authentication, sssd(sssd-ldap) has become the successor to nss-pam-ldapd. 

With authselect, you can easily set up external authentication using an existing external LDAP or Active Directory server(s). However, when using authselect, you will need to know how the authentication federation settings are managed for the host in question. Authentication federation is managed by the authselect profile. The current profile can be viewed with the `authselect current` command.

Authselect is enabled by default in RHEL8 and its derivatives. You must not modify files involved with NSS/PAM such as /etc/nsswitch.conf by hand.

You can overwrite these values by creating host_vars/localhost.yml and writing entries you want to change.

```
$ grep ^AS_LDAP group_vars/all
AS_LDAP_AUTH_ENABLED:   False
AS_LDAP_HOSTNAME1:  '{{ DS389_REPL_HOST1 }}'
AS_LDAP_HOSTNAME2:  '{{ DS389_REPL_HOST2 }}'
AS_LDAP_URI1:       'ldap://{{ AS_LDAP_HOSTNAME1 }}'
AS_LDAP_URI2:       'ldap://{{ AS_LDAP_HOSTNAME2 }}'
AS_LDAP_BASEDN:     '{{ DS389_SUFFIX }}'
AS_LDAP_BINDDN:     '{{ DS389_ROOT_DN }}'
```

Next, make sure AS_LDAP_HOSTNAME1 and AS_LDAP_HOSTNAME2 can be resolved by DNS or /etc/hosts.
And then run playbook.

```
$ ansible-playbook jobs/ldap-auth.yml
```

Note that winbind(AD auth) has not yet supported in this playbook.

If you are configuring replication on two 389ds and want to set up LDAP authentication on them, use jobs/389ds.yml instead. In this case, LDAP authentication is enabled by default.

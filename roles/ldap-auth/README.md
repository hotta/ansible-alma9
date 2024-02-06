# Activating LDAP Auth


Up to RHEL7, authconfig was used as a configuration tool for authentication linkage.  It has been deprecated since RHEL8, and authselect is provided as a successor. Also,  nss-pam-ldapd was using when using LDAP for external authentication, sssd(sssd-ldap) has become the successor to nss-pam-ldapd. 

With authselect, you can easily set up external authentication using an existing external LDAP or Active Directory server(s). However, when using authselect, you will need to know how the authentication federation settings are managed for the host in question. Authentication federation is managed by the authselect profile. The current profile can be viewed with the `authselect current` command.

Authselect is enabled by default in RHEL8 and its derivatives. You must not modify files involved with NSS/PAM such as /etc/nsswitch.conf by hand.

You can overwrite these values by creating host_vars/localhost.yml and writing entries you want to change.

```
$ grep ^AS_ group_vars/all
AS_LDAP_AUTH_ENABLED:   False
AS_PROFILE_ID:      'sssd'
AS_LDAP_URI1:       'ldap://ldap1.{{ PCA_DOMAIN_SUFFIX }}'
AS_LDAP_URI2:       'ldap://ldap2.{{ PCA_DOMAIN_SUFFIX }}'
AS_LDAP_BASEDN:     '{{ DS389_SUFFIX }}'
AS_LDAP_BINDDN:     '{{ DS389_ROOT_DN }}'
```

If you want to use ldap authentication, please follow the instructions:

1. Verify that the LDAP server to be specified in AS_LDAP_URI(default: ldap://ldap1.example.com and ldap://ldap2.example.com) is running and accessible from the host in question.
2. create or modify host_vars/localhost.yml
3. set AS_LDAP_AUTH_ENABLED to True and set other AS_* parameters properly.
4. Run ansible-playbook jobs/ldap-auth.yml
5. Check /var/log/sssd/* to make sure there are no errors.

Note that winbind(AD auth) has not yet supported in this playbook.

If you are configuring replication on two 389ds and want to set up LDAP authentication on them, use jobs/389ds.yml instead. In this case, LDAP authentication is enabled by default.

# Create Private CA and Server Certificates

This role is just for test and evaluation purpose only.
The auto configuration of web server for maintaining the CA, such as OCSP (Online Certificate Status Protocol) Responder and/or CRL((Certificate Revocatiom List) Distribution Poins, are not supported.

## Prerequisite

First, confirm your organization and change if needed.

```
$ cd ~/ansible-alma9/group_vars
$ cat private-ca.yml.tmpl               # Confirmation
$ cp private-ca.yml.tmpl private-ca.yml # only to change default values
$ vi pricate-ca.yml                     # - do -
```

If you want to use more than one server(s), modify the following:

- group_vars/pricate-ca.yml
    - PCA_HOSTNAME2, PCA_HOSTNAME3 ... (enable multiple servers)
- roles/private-ca/templates/{root,sub}-ca.conf
    - alt_names section
    - name_constraints section
- roles/server-cert/templates
    - create server2.conf, server3.conf by copying server2.conf.tmpl

TODO: The automatic configuration for multiple servers is not implemented.

## Execution

```
$ cd ~/ansible-alma9
$ ansible-playbook jobs/private-ca.yml
```

It will create following files IF THEY ARE NOT EXISTS.

- /tmp/root-ca/private/root-ca.key ( Root Certificate )
- /tmp/sub-ca/private/sub-ca.key ( Intermediate Certificate )
- /tmp/DOMAIN/SERVERNAME1.{key,csr,crt} - Server Certificate
- /tmp/DOMAIN/SERVERNAME2.{key,csr,crt} - Server Certificate(if server2 is enabled)
- /tmp/DOMAIN/SERVERNAME3.{key,csr,crt} - Server Certificate(if server3 is enabled)

If you want to run this role several times with try and error, 
please delete /tmp/root-ca and /tmp/sub-ca recursively before each run.

## Appendix

useful openssl sub commands :

- openssl help 
    - display help
- openssl genrsa -CIPHER [ -out KEYFILE.key ] KEYLEN 
    - create RSA key. See openssl help for -CIPHER
- openssl rsa -in KEYFILE.key -text 
    - display structure of the key file
- openssl rsa -in KEYFILE.key [ -out FILENAME.pub ] -pubout 
    - extract public key only
- openssl req -new -key KEYFILE.key -out FILENAME.csr 
    - create CSR conversationally from scratch using existing key file
- openssl req -new -config CONFIG.conf -out FILENAME.csr -keyout KEYFILE.key
    - create key and csr automatically
- openssl req -in FILENAME.csr -text -noout 
    - Reconfirm CSR
- openssl ca -selfsign -config CONFIG.conf -in FILENAME.csr -out FILENAME.crt -batch -extensions ca_ext
    - Create self-signed cert (for root ca)
- openssl ca -config CONFIG.conf -in FILENAME.csr -out FILENAME.crt -batch -extensions sub_ca_ext
    - Issue sub-ca cert under root-ca

filename extensions:

- .key - private key file
- .csr - CSR(Certificate Signing Request)
- .crt - Certificate file
- .conf - configuration file


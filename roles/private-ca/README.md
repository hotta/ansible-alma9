# Create Private CA and Server Certificates

```
ansible-playbook jobs/private-ca.yml
```

will create following files IF NOT EXISTS.

- /tmp/root-ca/root-ca.{key,csr,crt} - Root Certificates
- /tmp/root-ca/sub-ca.{key,csr,crt}  - Intermediate Certificates
- /tmp/root-ca/example.org/server.{key,csr,crt} - Server Certificates

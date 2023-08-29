# Deploying gitlab

1. Open group_vars/all using any editor to check the value of GITLAB_FQDN (default to "gitlab.example.org"). If you want to change, create custum config file host_vars/localhost.yml and redefine in it.
2. Append an entry of GITLAB_FQDN to your /etc/hosts.
3. Run "ansible-playbook jobs/gitlab.yml" to deploy gitlab-ee.
4. Using your browser, Visit GITLAB_FQDN.
5. Login as root. The password is written in /etc/gitlab/initial_root_password. This file will be automatically deleted in 24 hours. Please be careful.


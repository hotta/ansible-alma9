# Deploying gitlab

1. Create host_vars/localhost.yml.tmpl by copying localhost.yml.tmpl.
2. Open host_vars/localhost.yml using any editor to check the value of GITLAB_FQDN (default to "gitlab.example.org"). You may change PCA_HOSTNAME or PCA_DOMAIN_SUFFIX into any value. Do not change GITLAB_FQDN directly.
3. Run "ansible-playbook jobs/gitlab.yml" to deploy gitlab-ee.

# Before first login

Gitlab's root password is auto-generated and written in /etc/gitlab/initial_root_password, which is very long one. This file only exists in 24 hours.
Although, you can reset root password by doing following instruction.

```
$ sudo gitlab-rails console -e production
--------------------------------------------------------------------------------
 Ruby:         ruby 3.0.6p216 (2023-03-30 revision 23a532679b) [x86_64-linux]
 GitLab:       16.2.4-ee (9544e5451d7) EE
 GitLab Shell: 14.23.0
 PostgreSQL:   13.11
------------------------------------------------------------[ booted in 69.86s ]
Loading production environment (Rails 7.0.6)
irb(main)> user = User.find(1)
=> #<User id:1 @root>
irb(main)> user.password = 'New-Password'
=> "New-Password"
irb(main)> user.password_confirmation = 'New-Password'
=> "New-Password"
irb(main)> user.save!
=> true
irb(main)> exit
```

# the first login

1. Using your browser, Visit GITLAB_FQDN.
2. Login as root using the password you specified above.

# Login using glab command


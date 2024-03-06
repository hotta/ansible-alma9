# Ansible playbooks to provide a variety of functions.

## Minimum requirements

### using AlmaLinux-9.x

To create AlmaLinux-9 vagrant machine on Windows11:

```
PS> cat Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider "virtualbox" do |vb|
    vb.cpu = "1"
    vb.memory = "2048"
  end
  config.vm.define "alma9" do |alma9|
    alma9.vm.box = "generic/alma9"
    alma9.vm.hostname = "alma9"
  end
end
PS> vagrant up
```

If you want to run gitlab, the VM needs 6GB+ memory.

### User and permissions to run

It is intended to be run in a vagrant environment. So we assume following environment is set.

```
$ sudo cat /etc/sudoers.d/vagrant
%vagrant ALL=(ALL) NOPASSWD: ALL
```

Running this playbook by "root" user is not tested and not recommended.

## Set environment

```
$ sudo rpm --import https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux
$ sudo dnf -y update
$ sudo dnf -y install git epel-release glibc-langpack-ja
$ sudo dnf -y install ansible
$ git clone https://github.com/hotta/ansible-alma9 
$ cd ansible-alma9
$ ansible-galaxy collection install -r requirements.yml
```

I recommend you to take a vagrant snapshot at this point.


## Preparation

1. Show the job list.

```
$ cd ansible-alma9
$ ls jobs
```

2. You will see many yaml files. 
3. Detirmine a yaml file you want to create the environment for.
4. Read README file in roles/XXX (XXX corresponds jobs/XXX.yml) if any, then follow the instructions. 

## Execution

```
$ ansible-playbook jobs/XXX.yml
```

## Customization

First, Look at the group_vars/all. This file defines many of setting values. You may overwrite any variables defined here by creating host_vars/localhost.yml ( not the localhost.yml.tmp, It is just an example and never be read by ansible) and redefine the variable you want to overwrite in it.

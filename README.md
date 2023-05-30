# Ansible playbooks to build various features 

## Minimum requirements

### using AlmaLinux-9.x

To create AlmaLinux-9 vagrant machine on Windows11:

```
PS> cat Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider "virtualbox" do |hv|
    hv.memory = "2048"
  end
  config.vm.define "alma9" do |alma9|
    alma9.vm.box = "generic/alma9"
    alma9.vm.hostname = "alma9"
  end
end
PS> vagrant up
```

### User and permissions to run

It is intended to be run in a vagrant environment.

```
$ sudo cat /etc/sudoers.d/vagrant
%vagrant ALL=(ALL) NOPASSWD: ALL
```

## Preparation

```
$ sudo dnf -y update
$ sudo dnf -y install git epel-release glibc-langpack-ja
$ sudo dnf -y install ansible
$ git clone https://github.com/hotta/ansible-alma9 
$ cd ansible-alma9
$ ansible-galaxy collection install -r requirements.yml
```

I recommend you to take a vagrant snapshot at this point.

## Exceution

```
$ cd ansible-alma9
$ ansible-playbook jobs/XXX.yml
```

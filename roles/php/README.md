# Create PHP environment

You have nothing to do with php. The following description is just a memo.

## The wizard execution log at remi repo

http://rpms.remirepo.net/wizard/

Operating system and version selection
Operating system: 
    EL 9

Wanted PHP version: 
8.2.10 (active support until December 2024)

Type of installation: 
Default / Single version (simplest way)

Architecture: 
x86_64

Wizard answer
CentOS 9 provides PHP version 8.0, 8.1 in its official repository

Command to enabled the CRB repository:
    dnf config-manager --set-enabled crb

Command to install the EPEL repository configuration package:
    dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

Command to install the Remi repository configuration package:
    dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm


You want a single version which means replacing base packages from the distribution

Packages have the same name than the base repository, ie php-*

Some common dependencies are available in remi-safe repository, which is enabled by default

You have to enable the module stream for 8.2:
    dnf module reset php
    dnf module install php:remi-8.2

If an old version is installed, command to upgrade:
    dnf update

If no version is installed, command to install the php command:
    dnf install php-cli

Command to install additional packages (xxx for SAPI or extension name):
    dnf install php-xxx

Command to install testing packages:
    dnf --enablerepo=remi-modular-test install php-xxx

Command to check the installed version and available extensions:
    php --version
    php --modules


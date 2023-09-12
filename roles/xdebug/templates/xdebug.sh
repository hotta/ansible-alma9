#!/bin/bash

usage() {
    echo 'Usage xdebug.sh { on | off }'
    exit 0
}

if [ -z "$1" ] ; then
    usage
fi
if [ "$1" == "on" ] ; then
    sudo sed -ie 's/^.*zend_extension.*/zend_extension=xdebug.so/' /etc/php.d/15-xdebug.ini
    sudo systemctl restart php-fpm
    echo xdebug enabled.
elif [ "$1" == "off" ] ; then
    sudo sed -ie 's/zend_extension/; zend_extension/' /etc/php.d/15-xdebug.ini
    sudo systemctl restart php-fpm
    echo xdebug disabled.
else
    usage
fi

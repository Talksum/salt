#!/bin/sh

if [ $(id -u) != "0" ]; then
    echo "please use sudo when running $(basename $0)"
    exit 1
else
    /usr/local/bin/salt-cp -c /talksum/salt/master "$@"
fi

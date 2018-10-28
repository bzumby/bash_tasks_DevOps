#!/usr/bin/env bash

#final version

#check if ntp running
if [ -z "$(pgrep "ntp")" ]
then
echo "NOTICE: ntp is not running"

sudo systemctl start ntp.service
fi

#check if two files differ and print diff to output
if ! cmp -s /etc/ntp.conf /etc/ntp.conf.bak; then
        echo "NOTICE: /etc/ntp.conf was changed. Calculated diff: " ;
        diff -U 0 /etc/ntp.conf.bak /etc/ntp.conf;
        sudo cp /etc/ntp.conf.bak /etc/ntp.conf;
        sudo systemctl start ntp.service;
fi



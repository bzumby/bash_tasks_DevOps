#!/usr/bin/env bash

#final version


#remove ntp
#sudo apt-get remove --auto-remove ntp
#sudo apt-get purge ntp


#locate default ntp servers
#grep -E "pool.*[0-9]?\.ubuntu.+" ntp.conf

##########################################


#step 1 
#install ntp server
sudo apt-get -y install ntp >/dev/null 2>&1

#step 2 
#remove default ntp servers from /etc/ntp.conf
sed -i -r '/pool.*[0-9]?\.ubuntu.+/ d' /etc/ntp.conf

#step 3
#use custom NTP server in /etc/ntp.conf
echo 'server ua.pool.ntp.org iburst' >> /etc/ntp.conf

#step 4
#make a backup of ntp conf file
sudo cp /etc/ntp.conf /etc/ntp.conf.bak

#step 5
#restart NTP server
sudo systemctl restart ntp.service


#step 6
#add ntp_verify.sh to cron

(sudo crontab -l ; echo "* * * * * $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/ntp_verify.sh")| crontab -

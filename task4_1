#!/usr/bin/env bash

#output to file in the same dir where script is
exec &> $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/task4_1.out

#CPU model
cpu_inf=$(cat /proc/cpuinfo | grep 'model name' |cut -d ":" -f2|head -n1|  sed -e 's/^[ \t]*//')
#RAM total
ram_inf=$(grep MemTotal /proc/meminfo|cut -d ":" -f2| tr -d ' ' |tr '[:lower:]' '[:upper:]')

#Motherboard info TBD
brd_m=$(sudo dmidecode -s baseboard-manufacturer 2>/dev/null)
brd_pn=$(sudo dmidecode -s baseboard-product-name 2>/dev/null)

brd_info=""$brd_m""$brd_pn""

if [ -z "$brd_info" ]
then
brd_info="Unknown"
else
brd_info="$brd_m $brd_pn $brd_v"
fi

#system serial number
sys_num=$(sudo dmidecode -s system-serial-number 2>/dev/null)


if [ -z "$sys_num" ]
then
sys_num="Unknown"
fi


#OS distribution
os_distro=$(lsb_release -ds)

#Kernel version
kern_info=$(uname -r)

#Installed date
install_date=$(fs=$(df / | tail -1 | cut -f1 -d' ' ) && sudo tune2fs -l $fs | grep created|  awk '{print $4 " " $5 " " $7}')

#count running processes
proc_num=$(ps ax | wc -l | tr -d " ")

#count logged users
log_usr=$(uptime |cut -d ',' -f3| tr -dc [0-9])

#hostname
host=$(hostname)

#uptime in days
uptime=$(cat /proc/uptime)  
uptime=${uptime%%.*}
let uptime=${uptime%%.*}/60/60/24 

#HW info
echo -e "--- Hardware ---"
echo "CPU: $cpu_inf"
echo "RAM: $ram_inf"
echo "Motherboard: $brd_info"
echo "System Serial Number: $sys_num"

#System info
echo -e "--- System ---"
echo "OS Distribution: $os_distro"
echo "Kernel version: $kern_info"
echo "Installation date: $install_date"
echo "Hostname: $host"
echo "Uptime: $uptime days"
echo "Processes running: $proc_num"
echo "Users logged in: $log_usr"

#Network interfaces info
echo -e "--- Network ---"
#interfaces info
#ip -o -4 addr| awk '{print $2 ": " $4}'

#final version. it was hard as fuck
ip a| awk 'BEGIN{ORS=" "}  /mtu/ {print $2 } /inet / {print $2 "\n"}'| awk '{if ($2!=""){print $1" "$2} else {print $1 " -"}}'


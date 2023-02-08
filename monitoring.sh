#!/bin/bash

# Architecture
echo "#Architecture: $(uname -a)";
# I would prefer to split architecture/kernel version like this
# echo "#Architecture: $(uname -s -r)"
# echo "#Kernel version: $(uname -v)"
# But it doesn't match the example

# Processors
echo "#CPU physical : $(cat /proc/cpuinfo | grep '^physical id' | sort | uniq | wc -l)";
echo "#vCPU : $(cat /proc/cpuinfo | grep '^processor' | wc -l)";

# RAM
total_RAM_MB="$(free -m | sed -n 2p | awk '{print $2}')";
# echo $total_RAM_MB
used_RAM_MB="$(free -m | sed -n 2p | awk '{print $3}')";
# echo $used_RAM_MB
percentage_used_RAM="$(awk -v used=$used_RAM_MB -v total=$total_RAM_MB 'BEGIN {printf "%.2f", used / total * 100}')";
# echo $persentage_used_RAM
echo "#Memory Usage: $used_RAM_MB/${total_RAM_MB}MB ($percentage_used_RAM%)";

# Memory
total_memory="$(df --total --human | tail -n 1 | awk '{print $2}')"
used_memory="$(df --total --human | tail -n 1 | awk '{print $3}')"
percentage_used_memory="$(df --total --human | tail -n 1 | awk '{print $5}')"
echo "#Disk Usage: $used_memory/$total_memory ($percentage_used_memory)"

# CPU load
# idle_CPU="$(mpstat 2 1 | tail -n 1 | awk '{print $NF}')"
# used_CPU="$(awk -v idle=$idle_CPU 'BEGIN {printf "%.1f", 100 - idle}')"
# echo "#CPU load: $used_CPU%"

# Last boot
boot_time="$(who -b | awk '{print $3 " " $4}')"
echo "#Last boot: $boot_time"

# LVM use
lsblk --list -o TYPE -n | grep lvm -q
if [ $? -eq 0 ]
then
	echo "#LVM use: yes"
else
	echo "#LVM use: no"
fi

# Active TCP connections
number_tcp_connections="$(netstat --tcp | grep ESTABLISHED | wc -l)"
echo "#Connections TCP : $number_tcp_connections ESTABLISHED"

# Logged in users
number_of_users="$(w -h | awk '{print $1}' | sort | uniq | wc -l)"
echo "#User log: $number_of_users"

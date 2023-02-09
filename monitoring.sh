#!/bin/bash

# # Architecture
architecture_message="#Architecture: $(uname -a)"
# # I would prefer to split architecture/kernel version like this
# # echo "#Architecture: $(uname -s -r)"
# # echo "#Kernel version: $(uname -v)"
# # But it doesn't match the example

# # Processors
cpu_physical_message="#CPU physical : $(cat /proc/cpuinfo | grep '^physical id' | sort | uniq | wc -l)"
virtual_cpu_message="#vCPU : $(cat /proc/cpuinfo | grep '^processor' | wc -l)"

# RAM
total_RAM_MB="$(free -m | sed -n 2p | awk '{print $2}')"
# echo $total_RAM_MB
used_RAM_MB="$(free -m | sed -n 2p | awk '{print $3}')"
# echo $used_RAM_MB
percentage_used_RAM="$(awk -v used=$used_RAM_MB -v total=$total_RAM_MB 'BEGIN {printf "%.2f", used / total * 100}')"
# echo $persentage_used_RAM
ram_message="#Memory Usage: $used_RAM_MB/${total_RAM_MB}MB ($percentage_used_RAM%)"

# Disk
total_memory="$(df --total --human | tail -n 1 | awk '{print $2}')"
used_memory="$(df --total --human | tail -n 1 | awk '{print $3}')"
percentage_used_memory="$(df --total --human | tail -n 1 | awk '{print $5}')"
disk_message="#Disk Usage: $used_memory/$total_memory ($percentage_used_memory)"

#CPU load
idle_CPU="$(mpstat 2 1 | tail -n 1 | awk '{print $NF}')"
used_CPU="$(awk -v idle=$idle_CPU 'BEGIN {printf "%.1f", 100 - idle}')"
cpu_message="#CPU load: $used_CPU%"

# Last boot
boot_time="$(who -b | awk '{print $3 " " $4}')"
boot_message="#Last boot: $boot_time"

# LVM use
lsblk --list -o TYPE -n | grep lvm -q
if [ $? -eq 0 ]
then
	lvm_message="#LVM use: yes\n"
else
	lvm_message="#LVM use: no\n"
fi

# Active TCP connections
number_tcp_connections="$(netstat --tcp | grep ESTABLISHED | wc -l)"
tcp_message="#Connections TCP : $number_tcp_connections ESTABLISHED"

# Logged in users
number_of_users="$(w -h | awk '{print $1}' | sort | uniq | wc -l)"
users_message="#User log: $number_of_users"

# Network
ip="$(hostname -I)"
mac="$(ip -br link show | grep -v LOOPBACK | awk '{print $3}')"
network_message="Network: IP $ip($mac)"

# Sudo count
n_commands="$(journalctl -b | grep sudo | grep TTY | wc -l)"
sudo_message="#Sudo : $n_commands cmd"

wall \
$architecture_message$'\n'\
$cpu_physical_message$'\n'\
$virtual_cpu_message$'\n'\
$ram_message$'\n'\
$disk_message$'\n'\
$cpu_message$'\n'\
$boot_message$'\n'\
$lvm_message$'\n'\
$tcp_message$'\n'\
$users_message$'\n'\
$network_message$'\n'\
$sudo_message
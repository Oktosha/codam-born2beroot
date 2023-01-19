#!/bin/bash

# Output fancy banner
cat /sbin/cronjobs/banner.txt;

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
echo "#Memory Usage: $used_RAM_MB/$total_RAM_MB ($percentage_used_RAM%)";
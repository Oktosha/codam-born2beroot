#!/bin/bash

# Output fancy banner
# cat /sbin/cronjobs/banner.txt;

# Architecture
echo "#Architecture: $(uname -a)";
# I would prefer to split architecture/kernel version like this
# echo "#Architecture: $(uname -s -r)"
# echo "#Kernel version: $(uname -v)"
# But it doesn't match the example

# Processors
echo "#CPU physical : $(cat /proc/cpuinfo | grep '^physical id' | sort | uniq | wc -l)";
echo "#vCPU : $(cat /proc/cpuinfo | grep '^processor' | wc -l)";

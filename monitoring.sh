#!/bin/bash

arc=$(uname -a)
pcpu=$(lscpu | awk '/Socket/ {print $2}')
vcpu=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
fram=$(free -m | awk '/Mem:/ {print $2}')
uram=$(free -m | awk '/Mem:/ {print $3}')
pram=$(free | awk  '/Mem:/ {printf "%.2f", $3/$2*100}')
fdisk=$(df --total -h | awk '/total/ {print $2}')
udisk=$(df --total -m | awk '/total/ {print $3}')
pdisk=$(df --total -h | awk '/total/ {print $5}')
cpul=$(mpstat | awk '/all/ {print 100-$NF}')
lb=$(who -b | awk '/system/ {print $3 " " $4}')
lvmu=$(if [ $(lsblk -o TYPE | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
ctcp=$(netstat -nat | grep ESTABLISHED | wc -l)
ulog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | grep "ether" | awk '{print $2}')
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l)
wall "	#Architecture:	$arc
	#CPU physical:	$pcpu
	#vCPU:		$vcpu
	#Memory Usage:	$uram/${fram}MB ($pram%)
	#Disk Usage:	$udisk/${fdisk}B ($pdisk)
	#CPU load:	$cpul%
	#Last boot:	$lb
	#LVM use:	$lvmu
	#Connections TCP: $ctcp ESTABLISHED
	#User log:	$ulog
	#Newwork:	IP $ip ($mac)
	#Sudo:		$cmds cmd"

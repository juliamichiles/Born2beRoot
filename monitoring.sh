#!/bin/bash

#ARCH
arch=$(uname -a)

# CPU PHYSICAL
cpuf=$(grep "physical id" /proc/cpuinfo | wc -l)

# CPU VIRTUAL
cpuv=$(grep "processor" /proc/cpuinfo | wc -l)

# RAM
ram_total=$(free --mega | awk '$1=="Mem:"{print $2}')
ram_use=$(free --mega | awk '$1=="Mem:"{print $3}')
ram_percent=$(free --mega | awk '$1=="Mem:"{printf("%.2f", $3/$2*100)}')

# DISK
fdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%.2f\n", ut/ft*100)}')

# CPU LOAD
#cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%", $1 + $3)}')
cpul=$(top -bn1 | grep "%Cpu" | awk -F',' '{usage=0; for(i=1;i<=NF;i++){if($i !~ /id/) { val=substr($i,1,index($i," ")-1); usage+=val }}} END {printf("%.1f%%", usage)}')

# LAST BOOT
lb=$(who -b | awk '{print $3, $4}')

# LVM USE
lvmt=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)

# TCP CONNECTIONS
ctcp=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')

# USER LOG
ulog=$(users | wc -w)

#NETWORK 
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')

#SUDO
cmds=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)

wall "	#Architecture : $arch
	#CPU physical : $cpuf
	#vCPU : $cpuv
	#Memory Usage : $ram_use/${ram_total}MB ($ram_percent%)
	#Disk Usage : $udisk/${fdisk}Gb ($pdisk%)
	#CPU load : $cpul
	#Last boot : $lb
	#LVM use : $lvmu
	#Connections TCP : $ctcp ESTABLISHED
	#User log : $ulog
	#Network : IP $ip ($mac)
	#Sudo : $cmds cmd"


#===========================================================================
#
#          File:  sys_all.sh
# 
#   Description:  Outputs all relevant system info for diagnostic purposes.
# 
#       Options:  ---
#  Requirements:  free, hostname, grep, cut, awk, uname
#          Bugs:  ---
#         Notes:  ---
#
#       Version:  1.0
#       Created:  01/27/2014 05:08:23 PM CET
#      Revision:  ---
# 
#         Usage:  ./sys_all.sh 
# 
#        Output:  ---
#
#        Author:  Frank Milde (FM), frank.milde@posteo.de
#       Company:  ---
#
#===========================================================================

#!/bin/bash

#---------------------------------------------------------------------------
# globals
#---------------------------------------------------------------------------
HOSTNAME=$(hostname -s)
MACHINE_TYPE=$(sudo lshw -c system |grep product | cut -d: -f2)

# IP and network config
IP_ADDRS=$(ifconfig | \
  grep 'inet addr' | \
  grep -v '255.0.0.0' | \
  cut -f2 -d':' | \
  awk '{print $1}')

NETWORK_PCI=$(lspci -nnk | grep -i net -A2)
NETWORK_INTERFACES=$(cat /etc/network/interfaces)
NETWORK_RESOLVCONF=$(cat /etc/resolv.conf)
NETWORK_HOSTS=$(cat /etc/hosts)

NETWORK_CONFIG1=$(ifconfig -a)
NETWORK_CONFIG2=$(iwconfig)
NETWORK_CONFIG3=$(route -n) 

NETWORK_MANAGER1=$(cat /var/lib/NetworkManager/NetworkManager.state)
NETWORK_MANAGER2=$(cat /etc/NetworkManager/NetworkManager.conf)

NETWORK_UDEV=$(cat /etc/udev/rules.d/70-persistent-net.rules | \
  egrep -i 'device|sub' -A3)

#memory
MEMORY=$(cat /proc/meminfo | awk '{ if ($1 == "MemTotal:") { memtot = \
$2/1000 } else if ($1 == "MemFree:") { memfree = $2/1000 } } END { printf \
"%d/%dM", memfree, memtot }')

#cpu info
CPUS=$(cat /proc/cpuinfo | grep processor | wc -l | awk '{print $1}')
CPU_MHZ=$(cat /proc/cpuinfo | grep MHz | tail -n1 | awk '{print $4}')
CPU_TYPE=$(cat /proc/cpuinfo | \
  grep vendor_id | tail -n 1 | awk '{print $3}')
CPU_TYPE2=$(uname -m)
CPU_TYPE3=$(uname -p)

# operating system
OS_NAME=$(uname -s)
OS_OS=$(uname -o)
OS_ARCH=$(uname -i)
OS_KERNEL=$(uname -r)
OS_RELEASE=$(cat /etc/os-release | grep PRETTY_NAME | cut -f2 -d'=')
OS_EDITION=$(cat /etc/lsb-release| grep DISTRIB_DESCRIPTION | cut -f2 -d'=')
OS_APTGET_VERSION=$(apt-get --version | awk 'NR==1 {print $1, $2, $3, $4}')

# memory
UPTIME=$(uptime)
MEM=$(free -tmh)
SPACE=$(df -TH)

# devices
FULL_PCIINFO=$(lspci | cut -f3 -d':')
LSUSB=$(lsusb)
LSMOD=$(lsmod)

#===  FUNCTION  ============================================================
#          Name:  main
#   Description:  outputs all
#       Globals:  ---
#     Arguments:  ---
#       Returns:  ---
#===========================================================================
function main() {
echo ${MACHINE_TYPE}
echo "--------------------------------------------------------------------"
echo "Number of CPUs   : ${CPUS}"
echo "CPU Type         : ${CPU_TYPE2} ${CPU_TYPE3} ${CPU_MHZ} MHz"
echo "Memory           : ${MEMORY}"
echo "OS Release       : ${OS_RELEASE}"
echo "OS Edition       : ${OS_EDITION} ${OS_ARCH}"
echo "Kernel Version   : ${OS_NAME} ${OS_OS} ${OS_KERNEL}"
echo "Apt-get Version  : ${OS_APTGET_VERSION}"
echo "--------------------------------------------------------------------"
echo
echo "Network pci devices"
echo "--------------------------------------------------------------------"
echo "${NETWORK_PCI}"
echo "--------------------------------------------------------------------"
echo
echo "Network interfaces"
echo "--------------------------------------------------------------------"
echo "${NETWORK_INTERFACES}"
echo "--------------------------------------------------------------------"
echo
echo "Network /etc/resolv.conf"
echo "--------------------------------------------------------------------"
echo "${NETWORK_RESOLVCONF}"
echo "--------------------------------------------------------------------"
echo
echo "Network /etc/hosts"
echo "--------------------------------------------------------------------"
echo "${NETWORK_HOSTS}"
echo "--------------------------------------------------------------------"
echo
echo "Network ifconfig"
echo "--------------------------------------------------------------------"
echo "${NETWORK_CONFIG1}"
echo "--------------------------------------------------------------------"
echo
echo "Network iwconfig"
echo "--------------------------------------------------------------------"
echo "${NETWORK_CONFIG2}"
echo "--------------------------------------------------------------------"
echo
echo "Network route"
echo "--------------------------------------------------------------------"
echo "${NETWORK_CONFIG3}"
echo "--------------------------------------------------------------------"
echo
echo "Network udev rules"
echo "--------------------------------------------------------------------"
echo "${NETWORK_UDEV}"
echo "--------------------------------------------------------------------"
echo
echo "Network manager state"
echo "--------------------------------------------------------------------"
echo "${NETWORK_MANAGER1}"
echo "--------------------------------------------------------------------"
echo
echo "Network manager conf"
echo "--------------------------------------------------------------------"
echo "${NETWORK_MANAGER2}"
echo "--------------------------------------------------------------------"
echo
echo "Devices - lsmod"
echo "--------------------------------------------------------------------"
echo "${LSMOD}"
echo "--------------------------------------------------------------------"
echo
echo "Devices - full lspci"
echo "--------------------------------------------------------------------"
echo "${FULL_PCIINFO}"
echo "--------------------------------------------------------------------"
echo
echo "Devices - lsusb"
echo "--------------------------------------------------------------------"
echo "${LSUSB}"
echo "--------------------------------------------------------------------"
echo
echo "Memory"
echo "--------------------------------------------------------------------"
echo "${MEM}"
echo "--------------------------------------------------------------------"
echo
echo "Disk Space"
echo "--------------------------------------------------------------------"
echo "${SPACE}"
echo "--------------------------------------------------------------------"
echo
}

main "$@"

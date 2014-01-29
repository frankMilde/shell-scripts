#===========================================================================
#
#          File:  sys_general_setup.sh
# 
#   Description:  Outputs the general system setup, like OS, kernel version
#                 and lspci, lsmod and lsusb
# 
#       Options:  ---
#  Requirements:  free, hostname, grep, cut, awk, uname
#          Bugs:  ---
#         Notes:  ---
#
#       Version:  1.0
#       Created:  01/27/2014 06:10:19 PM CET
#      Revision:  ---
# 
#         Usage:  ./sys_general_setup.sh 
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
#machine info
MACHINE_TYPE=$(sudo lshw -c system |grep product | cut -d: -f2)
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

# devices
FULL_PCIINFO=$(lspci | cut -f3 -d':')
LSUSB=$(lsusb)
LSMOD=$(lsmod)

function main() {
#print it out
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
echo "Devices - full lspci"
echo "--------------------------------------------------------------------"
echo "${FULL_PCIINFO}"
echo "--------------------------------------------------------------------"
echo
echo "Devices - lsmod"
echo "--------------------------------------------------------------------"
echo "${LSMOD}"
echo "--------------------------------------------------------------------"
echo
echo "Devices - lsusb"
echo "--------------------------------------------------------------------"
echo "${LSUSB}"
echo "--------------------------------------------------------------------"
echo
}

main "$@"

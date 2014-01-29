#===========================================================================
#
#          File:  sys_network.sh
# 
#   Description:  Outputs all relevant network info for diagnostic purposes.
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
#         Usage:  ./sys_network.sh 
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
# IP and network config
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

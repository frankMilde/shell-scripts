#===========================================================================
#
#          File:  sys_memory
# 
#   Description:  Outputs all relevant memory info for diagnostic purposes.
# 
#       Options:  ---
#  Requirements:  free, uptime, df
#          Bugs:  ---
#         Notes:  ---
#
#       Version:  1.0
#       Created:  01/27/2014 05:08:23 PM CET
#      Revision:  ---
# 
#         Usage:  ./sys_memory.sh 
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
UPTIME=$(uptime)
MEM=$(free -t -m)
SPACE=$(df -TH)

#print it out
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

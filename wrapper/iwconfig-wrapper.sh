#===========================================================================
#
#          FILE:  iwconfig-wrapper.sh
# 
#   DESCRIPTION:  Wifi scan and connect 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#
#       VERSION:  1.0
#       CREATED:  
#      REVISION:  ---
# 
#         USAGE:  ./iwconfig-wrapper.sh 
# 
#        OUTPUT:  <+OUTPUT+>
#
#        AUTHOR:  Frank Milde (fm), frank.milde (at) posteo.de
#       COMPANY:  
#
#===========================================================================

#!/bin/bash

# Enforce Bash strict mode, see
# http://redsymbol.net/articles/unofficial-bash-strict-mode/'
set -e          # exit if any command [1] has a non-zero exit status
set -u          # a reference to any variable you havent previously defined
# - with the exceptions of $* and $@ - is an error
set -o pipefail # prevents errors in a pipeline from being masked.
set -o nounset  # Treat unset variables as an error
IFS=$'\n\t'     # meaning full Internal Field Separator - controls what Bash     calls word
# splitting

#---------------------------------------------------------------------------
# GLOBALS
#---------------------------------------------------------------------------
CMDLINE_ARGS=${1:-}
INTERFACE="$(ls /sys/class/net | tail -1)"

#---------------------------------------------------------------------------
# FUNCTIONS
#---------------------------------------------------------------------------
function greeting () {
  clear
  echo 
  echo -e "$(tput setaf 3)
----------------------------
---  Wifi configuration  ---
----------------------------
    $(tput sgr0)"
  echo 
}    # ----------  end of function greeting  ----------

function usage {
	echo
  echo "SYNOPSIS"
  echo "       $(basename ${0}) [option]"
  echo "OPTIONS"
  echo "       -h, --help"
  echo "              produces this help message "
	echo "       -s, --scan"
  echo "              scans for wifi networks "
	echo "       -c, --connect"
  echo "              connects to wifi network"
	echo "       -u, --status"
  echo "              displays connection status"
  echo
}    # ----------  end of function usage  ----------

function connect {
	local essid
	local key
	read -e -p "$(tput setaf 3)Enter network name (ESSID):$(tput sgr0)" essid
	read -e -p "$(tput setaf 3)Enter password in  (ASCII):$(tput sgr0)" key

	iwconfig ${INTERFACE} essid ${essid} key s:${key}
}

function status {
	local status="X$(/sbin/iwgetid)"
	if test "${status}" != "X" ; then
		local essid="$(/sbin/iwgetid |awk -F ":" '{print $2}'|sed -e 's/"//g')"
		local link="$(awk 'NR==3 {print $3}' /proc/net/wireless |sed -e 's/\.//g')"

		echo
		echo "          Connected to:   $(tput bold)$(tput setaf 1)${essid}$(tput sgr0)"
		echo "          Signal strengh: $(tput bold)$(tput setaf 1)${link}$(tput sgr0)/100"
	else
		echo
		echo "No wifi"
	fi
}

function scan {
	echo 
	iwlist ${INTERFACE} scan  | \
		egrep  -wi --color 'Cell|Encryption key|ESSID|WPA'

	echo
	echo
	echo "To get more info copy paste this in command line:"
  echo "$(tput setaf 3)iwlist ${INTERFACE} scan$(tput sgr0)"
}

#===  FUNCTION  ============================================================
#          NAME:  main
#   DESCRIPTION:  Runs all functions.
#       GLOBALS:  <CURSOR>
#     ARGUMENTS:  <++> 
#       RETURNS:  <++> 
#===========================================================================
function main() {
	while [ "${CMDLINE_ARGS}" != "" ]; 
	do
		case $1 in
			-h | --help ) usage
				exit
				;;
			-s | --scan ) scan
				exit
				;;
			-c | --connect ) connect
				exit
				;;
			-u | --status ) status
				exit
				;;
			* )           usage
				exit 1
		esac  # -----  end of case -----
		shift
	done  # -----  end of while  -----

	while true
	do
		clear

		greeting

		echo "$(tput setaf 3)=================  $(tput sgr0)"
		echo "$(tput setaf 3)      Menu         $(tput sgr0)"
		echo "$(tput setaf 3)=================  $(tput sgr0)"
		echo
		echo "$(tput setaf 3)[1] Scan    $(tput sgr0)"
		echo "$(tput setaf 3)[2] Connect $(tput sgr0)"
		echo "$(tput setaf 3)[3] Status  $(tput sgr0)"
		echo "$(tput setaf 3)[4] Exit    $(tput sgr0)"
		echo

		local choice
		read -e -p "$(tput setaf 3)Enter your selection:$(tput sgr0)" choice

		case "${choice}" in
			1)	scan;;
			2)  connect;;
			3)  status;;
			4)  exit 0;;
			*)  echo "$(tput setaf 2)Wrong choice.$(tput sgr0)"
		esac  # -----  end of case -----
		echo
		echo -e "$(tput setaf 3)Hit the <return> key to continue or <ctrl>-c to quit.$(tput sgr0)"
		read input
	done

	echo
	echo "$(tput setaf 3)Done.$(tput sgr0)"
}

main "$@"


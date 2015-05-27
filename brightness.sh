#===========================================================================
#
#          FILE:  brightness.sh
# 
#   DESCRIPTION:  Displays the current monitor brightness on laptop.
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
#         USAGE:  ./brightness.sh 
# 
#        OUTPUT:  <+OUTPUT+>
#
#        AUTHOR:  Frank Milde (fm), frank.milde (at) posteo.de
#       COMPANY:  
#
#===========================================================================

#!/bin/bash

# Enforce Bash strict mode, see
# 'http://redsymbol.net/articles/unofficial-bash-strict-mode/'
set -e          # exit if any command [1] has a non-zero exit status
set -u          # a reference to any variable you havent previously defined
# - with the exceptions of $* and $@ - is an error
set -o pipefail # prevents errors in a pipeline from being masked.
set -o nounset  # Treat unset variables as an error
IFS=$'\n\t'     # meaning full Internal Field Separator - controls what Bash     calls word
# splitting

#===  FUNCTION  ============================================================
#          NAME:  main
#   DESCRIPTION:  Runs all functions.
#       GLOBALS:  <CURSOR>
#     ARGUMENTS:   
#       RETURNS:  <++> 
#===========================================================================
function main() {
 now=`cat /sys/class/backlight/intel_backlight/actual_brightness`
 max=`cat /sys/class/backlight/intel_backlight/max_brightness`

 percent=`echo "($now/$max*100)" | bc -l`

 printf '%.0f\n' $percent
}

main "$@"


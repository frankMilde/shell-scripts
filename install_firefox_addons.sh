#===========================================================================
#
#          File:  install_firefox_addons.sh
# 
#   Description:  Installs essential firefox addons.
#                 Does not work at the moment
# 
#       Options:  ---
#  Requirements:  wget
#          Bugs:  Firefox does not recognize add-ons.
#         Notes:  This script is based on
#                 http://askubuntu.com/questions/73474/how-to-install-firefox-addon-from-command-line-in-scripts
#                 http://bernaerts.dyndns.org/linux/74-ubuntu/271-ubuntu-firefox-thunderbird-addon-commandline
#
#       Version:  1.0
#       Created:  01/18/2014 10:01:49 AM CET
#      Revision:  ---
# 
#         Usage:  ./install_firefox_addons.sh 
# 
#        Output:  <+OUTPUT+>
#
#        Author:  Frank Milde (FM), frank@mailbox.tu-berlin.de
#       Company:  TU Berlin
#
#===========================================================================

#!/bin/bash

function main() {

readonly ADDON=addon.xpi

wget -O ${ADDON} https://addons.mozilla.org/firefox/downloads/latest/261959/addon-261959-latest.xpi
readonly UID_ADDON=$(unzip -p ${ADDON} install.rdf | \
  grep "<em:id>{" | \
  head -n 1 | \
  sed 's/^.*>\(.*\)<.*$/\1/g')

mkdir -p ${HOME}/.mozilla/extensions/${UID_ADDON}
unzip ${ADDON} -d "${HOME}/.mozilla/extensions/${UID_ADDON}"
rm ${ADDON}
}

main "$@"

#===========================================================================
#
#          File:  conform_to_google.sh
# 
#   Description:  This script tries to conform other shell scripts to
#                 Googles Shell script style guide:
#                 https://google-styleguide.googlecode.com/svn/trunk/shell.xml
# 
#       Options:  ---
#  Requirements:  ---
#          Bugs:  ---
#         Notes:  ---
#
#       Version:  1.0
#       Created:  01/27/2014 01:35:11 PM CET
#      Revision:  ---
# 
#         Usage:  ./conform_to_google.sh your_script.sh
# 
#        Output:  
#
#        Author:  Frank Milde (FM), frank.milde (at) posteo.de
#       Company:  
#
#===========================================================================

#!/bin/bash

#---------------------------------------------------------------------------
# globals
#---------------------------------------------------------------------------
FILE=$1

#---------------------------------------------------------------------------
# functions
#---------------------------------------------------------------------------
function replace_backticks_by_dollar_brackets () {
  vim ${FILE} <<-EOF
    :% s/\$(\(.\+\)\)/\$(\1)/
    :wq
EOF
}    # ----------  end of function replace_backticks_by_dollar_brackets  ----------

function replace_dollar_variable_by_dollar_curlybrackets_variable () {
  vim ${FILE} <<-EOF
    :% s/\$\(\h\+\d\+\)/\${\1}/
    :% s/\$\(\h\+\)/\${\1}/
    :wq
EOF
}    # ----------  end of function replace_dollar_variable_by_dollar_curlybrackets_variable  ----------

function replace_tabs_with_spaces () {
  vim ${FILE} <<-EOF
    :set expandtab
    :retab
    :wq
EOF
}    # ----------  end of function replace_tabs_with_spaces  ----------

function main() {
  replace_dollar_variable_by_dollar_curlybrackets_variable
  replace_backticks_by_dollar_brackets
  replace_tabs_with_spaces
}

main "$@"

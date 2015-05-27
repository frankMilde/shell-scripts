NORMAL=$(tput sgr0)
RED=$(tput setaf 1)

echo -e "\nPulling dot-files..." | tee --append ~/git.log 
cd ~/dot-files
git pull origin master 2>&1 >>~/git.log | tee --append ~/git.log

if [ "$?" != "0" ]; then
	echo -e "\n$RED  Error in git pull of dot-files...$NORMAL " 1>&2
	sleep 2
fi
cd

echo -e "\nPulling shell scripts..." | tee --append ~/git.log 
cd ~/github/frankMilde/shell-scripts/
git pull origin master 2>&1 >> ~/git.log | tee --append ~/git.log 

if [ "$?" != "0" ]; then
	echo -e "\n$RED  Error in git pull of dot-files...$NORMAL " 1>&2
	sleep 2
fi
cd

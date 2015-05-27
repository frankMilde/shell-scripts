echo -e "\nPushing dot-files..."
cd ~/dot-files
git push origin master
if [ "$?" != "0" ]; then
	echo -e "\n$RED  Error in git push of dot-files...$NORMAL " 1>&2
	sleep 5
fi
cd

echo -e "\nPushing shell scripts..."
cd ~/github/shell-scripts/
git push origin master
if [ "$?" != "0" ]; then
	echo -e "\n$RED  Error in git push of shellscripts...$NORMAL " 1>&2
	sleep 5
fi
cd

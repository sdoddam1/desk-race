#!/bin/bash

if [[ $EUID -ne 0 ]];
then
	echo "Run the script as root"
	exit 1
fi

# Remove tmux package
status=$(dpkg -s tmux 2> /dev/null | grep -ie "ok installed")
if [[ ! -z "${status}" ]];
then
	apt purge --autoremove tmux
else
	echo "tmux is not installed!"
fi

# Remove tmux config files
tmux_dir="$HOME/.tmux/"
if [[ -d ${tmux_dir} ]];
then
	rm -rf .tmux/
fi

#!/bin/bash

# Change default shell to bash before 
# uninstalling zsh
default_shell=$(echo $SHELL)
echo ${default_shell}
if [[ ${default_shell} == "/bin/zsh" ]];
then
	echo "----------------------"
	echo "default shell is zsh"
	echo "Changing to bash ..."
	echo "----------------------"
	chsh -s /bin/bash $(whoami)
	echo ${SHELL}
else
	echo "--------------------------"
	echo "zsh is not default shell"
	echo "--------------------------"
fi

# Uninstall oh-my-zsh
oh_my_zsh_dir="$HOME/.oh-my-zsh/tools/"
if [[ -d ${oh_my_zsh_dir} ]];
then
	echo "----------------------------------"
	echo "Removing directory oh-my-zsh ..."
	echo "----------------------------------"
	cd .oh-my-zsh/tools
	sh uninstall.sh
fi

# Uninstall zsh
status=$(dpkg -s zsh 2> /dev/null | grep -ie "ok installed")
if [[ ! -z "${status}" ]];
then
	echo "--------------------------"
	echo "Removing zsh package ..."
	sudo apt purge --autoremove zsh
	echo "--------------------------"
else
	echo "-----------------------"
	echo "zsh is not installed!"
	echo "-----------------------"
fi

#!/bin/bash

# SETUP TMUX
status=$(dpkg -s tmux 2> /dev/null | grep -ie 'ok installed')
if [[ -z "${status}" ]]
then
	echo "------------------------ "
	echo "tmux is not installed"
	echo "Installing tmux ..."
	echo "------------------------ "
	sudo apt install tmux
else
	echo "----------------------------"
	echo "tmux is already installed!"
	echo "----------------------------"
fi

## Clone tmux plugin manager
tpm_dir="$HOME/.tmux/plugins/tpm/"
if [[ ! -d "${tpm_dir}" ]];
then
	echo "----------------------------"
	echo "Cloning tpm repository ..."
	echo "----------------------------"
	git clone https://github.com/tmux-plugins/tpm ${tpm_dir}
else
	echo "--------------------------------------"
	echo "tmux plugin manager already exists!"
	echo "--------------------------------------"
fi

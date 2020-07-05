#!/bin/bash

## Uninstall alacritty
alacritty_dir="$HOME/alacritty"
if [[ -d "${alacritty_dir}" ]];
then
	echo "----------------------------------"
	echo "Deleting directory alacritty ..."
	echo "----------------------------------"
	sudo rm -rf ${alacritty_dir}
fi

#!/bin/bash

status=$(dpkg -s i3 2> /dev/null | grep -ie "ok installed")
if [[ -z "${status}" ]];
then
	echo "--------------------"
	echo "Installing i3 ..."
	echo "--------------------"
	sudo apt install i3
else
	echo "--------------------------"
	echo "i3 is already installed!"
	echo "--------------------------"
fi

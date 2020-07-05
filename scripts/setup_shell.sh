#!/bin/bash

## Install zsh
status=$(dpkg -s zsh 2> /dev/null | grep -ie 'ok installed')
if [[ -z "${status}" ]];
then
	echo "---------------------"
	echo "zsh not installed"
	echo "Installing zsh ..."
	echo "---------------------"
	sudo apt install zsh
else
	echo "---------------------------"
	echo "zsh is already installed!"
	echo "---------------------------"
fi

## Create .zshrc file
echo "--------------------------------------------"
echo "Open new terminal" 
echo "Press 2 to create .zshrc file and hit Enter"
echo "--------------------------------------------"
while [ true ]; 
do
	read -t 5 -n 1
	if [ $? = 0 ]; 
	then
		break;
	else
		echo "---------------------------------"
		echo "Press enter key after setup ..."
		echo "---------------------------------"
	fi
done

## Set zsh as default shell
case $SHELL in
*/bash)
	echo "-----------------------------------"
	echo "Changing default shell to zsh ..."
	echo "-----------------------------------"
	chsh -s $(which zsh)
	echo "--------"
	echo ${SHELL} 						#### Logout and login to set zsh as default shell and hit 2
	zsh --version
	echo "--------"
esac

## Install oh-my-zsh shell plugin
oh_my_zsh_dir="$HOME/.oh-my-zsh/"
if [[ ! -d "${oh_my_zsh_dir}" ]];
then
	echo "--------------------------"
	echo "Installing oh-my-zsh ..."
	echo "--------------------------"
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "---------------------------------"
	echo "oh-my-zsh is already installed!"
	echo "---------------------------------"
fi

## Install autosuggestions plugin
plugin_dir="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/"
echo "${plugin_dir}"
if [[ ! -d "${plugin_dir}" ]];
then
	echo "---------------------------------------"
	echo "Installing autosuggestions plugin ..."
	echo "---------------------------------------"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	source "$HOME/.zshrc"
else
	echo "----------------------------------------------"
	echo "autosuggestions plugin is already installed!"	
	echo "----------------------------------------------"
fi

## Install powerlevel10k zsh theme
plugin_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [[ ! -d "${plugin_dir}" ]];
then
	echo "------------------------------------"
	echo "Installing powerlevel10k theme ..."
	echo "------------------------------------"
	git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
	source "$HOME/.zshrc"
else
	echo "-------------------------------------------"
	echo "powerlevel10k theme is already installed!"
	echo "-------------------------------------------"
fi

## TODO: Font installation ##

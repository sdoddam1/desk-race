#!/bin/bash

# INSTALL ALACRITTY

### Pre-requisites 
## rust/cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source .cargo/env
rustup override set stable
rustup update stable

## Required packages 
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

## Clone alacritty repository and setup
alacritty_dir="$HOME/alacritty"
if [[ ! -d "${alacritty_dir}" ]];
then
	echo "--------------------------"
	echo "Installing alacritty ..."
	echo "--------------------------"
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty
	cargo build --release

	## Desktop entry
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
	sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	sudo desktop-file-install extra/linux/Alacritty.desktop
	sudo update-desktop-database

	## Manual page
	sudo mkdir -p /usr/local/share/man/man1
	gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

	## Zsh shell completions
	default_shell=$(echo "$SHELL")
	if [[ "${default_shell}" != "/usr/bin/zsh" ]];
	then
		./setup_shell.sh
	fi
	mkdir -p ${ZDOTDIR:-~}/.zsh_functions
	echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
	cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

	## Copy alacritty.yml
	cp alacritty.yml ~/.alacritty.yml

	## Set alacritty as default terminal
	gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

	## Remove alacritty directory
	cd ..
	rm -rf alacritty
else
	echo "alacritty is already installed!"
fi



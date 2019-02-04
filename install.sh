#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# Script de instalacion del entorno: neovim, tmux, zsh, ranger y tilix. Junto
# con todas sus dependencias en Arch Linux
#-------------------------------------------------------------------------------

function aur_install {
	mkdir $(pwd)/pkgs;
	echo "INSTALANDO $1...";
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz -O $(pwd)/pkgs/$1.tar.gz &&\
		cd $(pwd)/pkgs &&\
		tar xfv $1.tar.gz &&\
		cd $1 &&\
		makepkg -sri;
	cd $(pwd);
}

# INSTALL DEPENDENCIES FOR ARCHLINUX
#-------------------------------------------------------------------------------
aur_install universal-ctags-git
aur_install global
sudo python3 -m pip install pynvim ueberzug
sudo pacman -Syu --noconfirm w3m composer xclip xsel
composer global require phpmd/phpmd squizlabs/php_codesniffer phpstan/phpstan friendsofphp/php-cs-fixer

# MAKE SYMBOL LINKS AND LOAD CONFIGS
#-------------------------------------------------------------------------------
dconf load /com/gexperts/Tilix/ < $HOME/dotfiles/tilix.conf
rm -rf $HOME/.zshrc; ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
rm -rf $HOME/.config/nvim/init.vim; ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
rm -rf $HOME/.config/nvim/after; mkdir -p $HOME/.config/nvim/after; ln -s $HOME/dotfiles/ftplugin $HOME/.config/nvim/after/ftplugin
rm -rf $HOME/.tmux.conf; ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
rm -rf $HOME/.config/ranger/rc.conf; ln -s $HOME/dotfiles/ranger/rc.conf $HOME/.config/ranger/rc.conf

#!/usr/bin/env bash

# Este es el script de instalacion del entorno neovim junto con todas sus
# dependencias en arch linux
#-------------------------------------------------------------------------------

function aur_install {
	echo "INSTALANDO $1...";
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz -O pkgs/$1.tar.gz &&\
		cd pkgs &&\
		tar xfv $1.tar.gz &&\
		cd $1 &&\
		makepkg -sri;
	cd $HOME/dotfiles;
}

# INSTALL DEPENDENCIES FOR ARCHLINUX
#-------------------------------------------------------------------------------
aur_install universal-ctags-git
aur_install global
sudo python3 -m pip install pynvim ueberzug
sudo pacman -Syu --noconfirm w3m composer
composer global require phpmd/phpmd squizlabs/php_codesniffer phpstan/phpstan friendsofphp/php-cs-fixer
dconf load /com/gexperts/Tilix/ < $HOME/dotfiles/tilix.conf

# MAKE SYMBOL LINKS
#-------------------------------------------------------------------------------
rm $HOME/.zshrc && ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
rm $HOME/.config/nvim/init.vim && ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
rm -rf $HOME/.config/nvim/after && mkdir -p $HOME/.config/nvim/after && ln -s $HOME/dotfiles/ftplugin $HOME/.config/nvim/after/ftplugin
rm -rf $HOME/.tmux.conf && ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
rm -rf $HOME/.config/ranger/rc.conf && ln -s $HOME/dotfiles/ranger/rc.conf $HOME/.config/ranger/rc.conf

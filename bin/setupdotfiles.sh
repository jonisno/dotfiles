#!/bin/bash

setupdotfiles() {
		# remove old files
		rm ~/.bashrc ~/.vimrc ~/.gitconfig
		rm -r ~/.vimrc

		# symlink needed dotfiles.
		ln -s ~/dotfiles/vimrc ~/.vimrc
		ln -s ~/dotfiles/bashrc ~/.bashrc
		ln -s ~/dotfiles/gitconfig ~/.gitconfig
		ln -s ~/dotfiles/vim ~/.vim

		# tmp directory for temporary vim files.
		mdkir ~/dotfiles/tmp
		
		if [ -d "~/dotfiles/vim/bundle" ] ; then
			git clone git@github.com:gmarik/Vundle.vim.git vim/bundle/Vundle.vim
			vim +BundleInstall +qall
		fi;
}

read -p "This may overwrite shit, y/n? " yn
case $in in
	[Yy]* ) setupdotfiles();;
	[Nn]* ) echo "Aborted";;
esac

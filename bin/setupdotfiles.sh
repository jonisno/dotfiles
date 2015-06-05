#!/bin/bash

initialize() {
	DOTDIR="$HOME/dotfiles"

	for i in .{vimrc,bashrc,gitconfig,vim}
	do
		if [ ! -f "$HOME/${i}" -a ! -L "$HOME/${i}" ] ; then
			ln -s $DOTDIR/${i:1} ~/${i}
		fi
	done

	# check for bundle
	BUNDLEDIR="$DOTDIR/vim/bundle"
	if [ ! -d "$BUNDLEDIR" ] ; then
		mkdir -p $BUNDLEDIR
		git clone git@github.com:gmarik/Vundle.vim.git $BUNDLEDIR/Vundle.vim
	fi

	if [ ! -d "$DOTDIR/tmp" ] ; then
		mkdir -p "$DOTDIR/tmp"
	fi

	. ~/.bashrc
	vim +BundleInstall +qall
}

echo "This will delete .bashrc .vimrc and .gitconfig plus the .vim directory in your $HOME folder."
read -p "Initialize and delete, y/n? " yn
case "$yn" in
	y|Y)
		echo "Deleting old files."
		rm $HOME/.bashrc $HOME/.vimrc $HOME/.gitconfig
		rm -rf $HOME/.vim
		rm -rf $HOME/dotfiles/vim/bundle
		initialize
	;;
	n|N)
		echo "Aborting, bye.."
		exit 0
	;;
	*)
		echo "Invalid option."
		exit 0
esac

#!/bin/bash

DOTDIR="$HOME/dotfiles"

# symlink needed dotfiles.

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

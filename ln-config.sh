#!/bin/sh

### rm -rf ~/.zshrc
### cp `pwd`/.zshrc ~/.zshrc

#rm -rf ~/.gvimrc
rm -rf ~/.gitconfig
rm -rf ~/.gitignore-rkmathi
rm -rf ~/.hgrc
rm -rf ~/.tmux
rm -rf ~/.vimrc
rm -rf ~/.vim
rm -rf ~/.zsh

# ln -s `pwd`/.gvimrc ~/.gvimrc
ln -s `pwd`/.gitconfig ~/.gitconfig
ln -s `pwd`/.gitignore-rkmathi ~/.gitignore-rkmathi
ln -s `pwd`/.hgrc ~/.hgrc
ln -s `pwd`/.tmux ~/.tmux
ln -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/.vim ~/.vim
ln -s `pwd`/.zsh ~/.zsh


#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os

def install_basics():
    os.system("""
rm -rf ~/.gitconfig
ln -s `pwd`/.gitconfig ~/.gitconfig
rm -rf ~/.gitignore-rkmathi
ln -s `pwd`/.gitignore-rkmathi ~/.gitignore-rkmathi
rm -rf ~/.hgrc
ln -s `pwd`/.hgrc ~/.hgrc
rm -rf ~/.tmux
ln -s `pwd`/.tmux ~/.tmux
rm -rf ~/.vimrc
ln -s `pwd`/.vimrc ~/.vimrc
rm -rf ~/.vim
ln -s `pwd`/.vim ~/.vim
rm -rf ~/.zsh
ln -s `pwd`/.zsh ~/.zsh
rm -rf ~/.zshrc
cp `pwd`/.zshrc ~/.zshrc
vi ~/.zshrc
    """)
    sys.exit(0)

def install_guis():
    os.system("""
rm -rf ~/.gvimrc
ln -s `pwd`/.gvimrc ~/.gvimrc
rm -rf ~/.xmonad
ln -s `pwd`/.xmonad ~/.
    """)
    sys.exit(0)

def install_error():
    sys.exit("Usage: python install-script.py [gui|cui]")

if len(sys.argv) != 2:
    install_error()
elif sys.argv[1] == 'gui' or sys.argv[1] == 'g':
    install_basics()
    install_guis()
elif sys.argv[1] == 'cui' or sys.argv[1] == 'c':
    install_basics()
else:
    install_error()

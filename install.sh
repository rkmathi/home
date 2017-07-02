#!/usr/bin/env bash

set -eu

### Variables
PATTERN_CUI="^(c)$"
PATTERN_GUI="^(g)$"
PATTERN_MAC="^(m)$"
PATTERN_WIN="^(w)$"
CP_A_GROUP=(
  ".zshrc"
)
LN_S_GROUP=(
  ".config/nvim/dein.toml"
  ".config/nvim/init.vim"
  ".gitconfig"
  ".vim"
  ".Xresources"
  ".zsh.d"
)


function goto_error() {
  cat << EOS
Usage:
  $ ./install.sh -[Environment]
Example:
  $ ./install.sh -m
Environment:
  -c : Linux (CUI)
  -g : Linux (GUI)
  -m : macOS
  -w : Windows
EOS
  exit 1
}

function copy_file() {
  \cp -afv `pwd`/$1 $HOME/$1
}

function link_file() {
  \ln -fsv `pwd`/$1 $HOME/$1
}

function link_env_file() {
  pattern="\/\.+$"
  if [[ ! $1 =~ $pattern ]]; then
    filename=`echo $1 | \awk -F'/' '{print $NF}'`
    ln -fsv `pwd`/$1 $HOME/$filename
  fi
}

function mkdir_dirs() {
  mkdir -p ~/.config/nvim
  mkdir -p ~/.vim
  mkdir -p ~/.zsh.d
}

function global_install() {
  for file in ${CP_A_GROUP[@]}; do copy_file $file; done
  for file in ${LN_S_GROUP[@]}; do link_file $file; done
}

function env_install() {
  env_path="envs/$env_type/"
  case "$1" in
    "cui" )
      echo "Linux CUI"
      for file in ${env_path}.*; do link_env_file $file; done
      ;;
    "gui" )
      echo "Linux GUI"
      for file in ${env_path}.*; do link_env_file $file; done
      ;;
    "mac" )
      echo "macOS"
      for file in ${env_path}.*; do link_env_file $file; done
      ;;
    "win" )
      echo "Windows"
      for file in ${env_path}.*; do link_env_file $file; done
      ;;
    * )
      echo "Invalid env_type"
      goto_error
      ;;
  esac
}


while getopts ":cgmw" opts; do
  case ${opts} in
    c ) env_type="cui" ;;
    g ) env_type="gui" ;;
    m ) env_type="mac" ;;
    w ) env_type="win" ;;
    \? ) echo "Invalid option"; goto_error ;;
  esac
done
shift `expr $OPTIND - 1`
if [ -z $env_type ]; then echo "No option error"; goto_error; fi

mkdir_dirs
global_install
env_install $env_type

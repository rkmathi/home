#!/bin/bash

### Variables
PATTERN_LIG="^(lg|linux-gui)$"    # linux-gui
PATTERN_LIS="^l(c|inux-cui)$"     # linux-cui
PATTERN_OSX="^o(|sx)$"            # osx
PATTERN_WIN="^w(|indows)$"        # windows
COPY_GROUP=(
".zshrc"
)
LINK_GROUP=(
".ctags"
".gitconfig"
".gitignore-rkmathi"
".hgrc"
".rubocop.yml"
".sbtconfig"
".tigrc"
".vim"
".zsh-syntax-highlighting"
)


### Functions
function goto_error() {
  cat << _EOT_
Usage:
  $ ./install.sh -[Environment] [want_to_install_additional]
Example:
  $ ./install.sh -o .xmonad
Environment:
  -c : Linux CUI
  -g : Linux GUI
  -o : OS X
  -w : Windows
_EOT_
  exit -1
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

function must_install() {
  echo "MUST INSTALL"
  for file in ${COPY_GROUP[@]}; do copy_file $file; done
  for file in ${LINK_GROUP[@]}; do link_file $file; done
}

function env_install() {
  env_path="envs/$env_type/"
  case "$1" in
    "lic" )
      echo "Linux CUI"
      for file in ${env_path}.*; do link_env_file $file; done
      ;;
    "lig" )
      echo "Linux GUI"
      for file in ${env_path}.*; do link_env_file $file; done
      ;;
    "osx" )
      echo "OSX"
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

function additional_install() {
  if [ $# -gt 0 ]; then
    echo "ADDITIONAL INSTALL"
    for file in $@; do ln_file $file ; done
  fi
}


### Main
while getopts ":cgow" opts; do
  case ${opts} in
    c ) env_type="lic" ;;
    g ) env_type="lig" ;;
    o ) env_type="osx" ;;
    w ) env_type="win" ;;
    \? ) echo "Invalid option"; goto_error ;;
  esac
done
shift `expr $OPTIND - 1`
if [ -z $env_type ]; then echo "No option error"; goto_error; fi

must_install
env_install $env_type
additional_install $@


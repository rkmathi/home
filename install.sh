#!/bin/bash

PATTERN_LIG="^(lg|linux-gui)$"    # linux-gui
PATTERN_LIS="^l(c|inux-cui)$"     # linux-cui
PATTERN_OSX="^o(|sx)$"            # osx
PATTERN_WIN="^w(|indows)$"        # windows
_CP_GROUP=(
".zshrc"
)
_LN_GROUP=(
".ctags"
".gitconfig"
".gitignore-rkmathi"
".hgrc"
".sbtconfig"
".vim"
".vimrc"
".zsh-syntax-highlighting"
)
LIG_LN_GROUP=(
".gvimrc"
".tmux.conf"
".xmonad"
".zshrc.env"
)
LIC_LN_GROUP=(
".tmux.conf"
".zshrc.env"
)
OSX_LN_GROUP=(
".gvimrc"
".tmux.conf"
".zshrc.env"
)
WIN_LN_GROUP=(
)


function goto_error() {
  cat << _EOT_
Usage:
  $ ./install.sh -e [Environment] (-w want_to_install_additional)
Example:
  $ ./install.sh -e osx (-w .gvimrc .xmonad ...)
Options:
  -e :
    (l lc linux-cui)
    (lg linux-gui)
    (o  osx)
    (w  windows)
  -w :
    (.gvimrc .xmonad )
_EOT_
  exit -1
}

function cp_file() {
  cp -fv `pwd`/$1 $HOME/$1
}

function ln_file() {
  ln -fsv `pwd`/$1 $HOME/$1
}

function ln_env_file() {
  ln -fsv `pwd`/envs/$env_type/$1 $HOME/$1
}

function must_install() {
  echo "MUST INSTALL"
  for file in ${_CP_GROUP[@]}; do cp_file $file ; done
  for file in ${_LN_GROUP[@]}; do ln_file $file ; done
}

function env_install() {
  if   [[ $env_type = "lig" ]]; then
    echo "Linux GUI"
    for file in ${LIG_LN_GROUP[@]}; do ln_env_file $file ; done
  elif [[ $env_type = "lic" ]]; then
    echo "Linux CUI"
    for file in ${LIC_LN_GROUP[@]}; do ln_env_file $file ; done
  elif [[ $env_type = "osx" ]]; then
    echo "OSX"
    for file in ${OSX_LN_GROUP[@]}; do ln_env_file $file ; done
  elif [[ $env_type = "win" ]]; then
    echo "WIN"
    for file in ${WIN_LN_GROUP[@]}; do ln_env_file $file ; done
  fi
}


while getopts ":e:w" opts; do
  case ${opts} in
    e )
      if   [[ $OPTARG =~ $PATTERN_LIG ]]; then
        env_type="lig"
      elif [[ $OPTARG =~ $PATTERN_LIC ]]; then
        env_type="lic"
      elif [[ $OPTARG =~ $PATTERN_OSX ]]; then
        env_type="osx"
      elif [[ $OPTARG =~ $PATTERN_WIN ]]; then
        env_type="win"
      else
        echo "Invalid Environment option"
        goto_error
      fi
      ;;
    w )
      with_file="true"
      ;;
    * )
      echo "Invalid option"
      goto_error
      ;;
  esac
done
shift `expr $OPTIND - 1`

if [ -z $env_type ]; then
  echo "No env_type"
  goto_error
fi

must_install
env_install
if [[ $with_file = "true" ]]; then
  echo "(with $@)"
  for file in $@; do ln_file $file ; done
fi


#!/bin/bash

PATTERN_CUI="^c(|ui)$"           # cui
PATTERN_GUI="^g(|ui)$"            # gui
PATTERN_LIN="^l(|inux)$"    # linux
PATTERN_OSX="^o(|sx)$"            # osx
PATTERN_WIN="^w(|indows)$" # windows
_CP_GROUP=(
".zshrc"
)
_LN_GROUP=(
".ctags"
".gitconfig"
".gitignore-rkmathi"
".hgrc"
".sbtconfig"
".tmux"
".vim"
".vimrc"
".zsh.d"
)
CUI_LN_GROUP=(
)
GUI_LN_GROUP=(
".gvimrc"
)
LIN_LN_GROUP=(
)
OSX_LN_GROUP=(
)
WIN_LN_GROUP=(
)


function goto_error() {
  cat << _EOT_
Usage:
  $ ./install.sh -u [CUI/GUI] -o [Linux/OSX/Windows] (-w want_to_install)
Example:
  $ ./install.sh -u cui -o osx (-w .xmonad ...)
Options:
  -u :
    (c cui)
    (g gui)
  -o :
    (l linux)
    (o osx)
    (w windows)
  -w :
    (.xmonad )
_EOT_
  exit -1
}

function cp_file() {
  echo "cp -fv `pwd`/$1 $HOME/$1"
}

function ln_file() {
  echo "ln -fsv `pwd`/$1 $HOME/$1"
}

function must_install() {
  for file in ${_CP_GROUP[@]}; do cp_file $file ; done
  for file in ${_LN_GROUP[@]}; do ln_file $file ; done
}

function ui_install() {
  if [[ $ui_type = "cui" ]]; then
    echo "CUI"
    for file in ${CUI_LN_GROUP[@]}; do ln_file $file ; done
  elif [[ $ui_type = "gui" ]]; then
    echo "GUI"
    for file in ${GUI_LN_GROUP[@]}; do ln_file $file ; done
  fi
}

function os_install() {
  if [[ $os_type = "lin" ]]; then
    echo "Linux"
    for file in ${LIN_LN_GROUP[@]}; do ln_file $file ; done
  elif [[ $os_type = "osx" ]]; then
    echo "OSX"
    for file in ${OSX_LN_GROUP[@]}; do ln_file $file ; done
  elif [[ $os_type = "win" ]]; then
    echo "WIN"
    for file in ${WIN_LN_GROUP[@]}; do ln_file $file ; done
  fi

}


while getopts ":u:o:w" opts; do
  case ${opts} in
    u )
      if [[ $OPTARG =~ $PATTERN_CUI ]]; then
        ui_type="cui"
      elif [[ $OPTARG =~ $PATTERN_GUI ]]; then
        ui_type="gui"
      else
        echo "Invalid UI option"
        goto_error
      fi
      ;;
    o )
      if   [[ $OPTARG =~ $PATTERN_LIN ]]; then
        os_type="lin"
      elif [[ $OPTARG =~ $PATTERN_OSX ]]; then
        os_type="osx"
      elif [[ $OPTARG =~ $PATTERN_WIN ]]; then
        os_type="win"
      else
        echo "Invalid OS option"
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

if [ -z $ui_type ] || [ -z $os_type ]; then
  echo "No ui_type or os_type"
  goto_error
fi

echo "Install type => $ui_type / $os_type"
if [[ $with_file = "true" ]]; then
  with_file=$@
  echo "(with $with_file)"
fi

must_install
ui_install
os_install



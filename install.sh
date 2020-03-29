#!/bin/bash
set -eu

COMMON_MKDIR_PATHS=(
  "~/.config/nvim"
  "~/.zsh.d"
)
COMMON_COPY_FILES=(
  ".zshrc"
)
COMMON_LINK_FILES=(
  ".config/nvim/dein.toml"
  ".config/nvim/init.vim"
  ".gitconfig"
  ".gitignore-rkmathi"
  ".Xresources"
  ".zsh.d/zsh-syntax-highlighting"
)

function goto_error() {
  cat << EOS
Usage:
  $ ./install.sh -[Environment]
Environment:
  -l : Linux
  -m : macOS
  -w : Windows
EOS
  exit 1
}

function install_common_files() {
  for path in ${COMMON_MKDIR_PATHS[@]}; do \mkdir -p ${path}; done
  for file in ${COMMON_COPY_FILES[@]}; do \cp -afv $(pwd)/${file} ${HOME}/${file}; done
  for file in ${COMMON_LINK_FILES[@]}; do \ln -fsv $(pwd)/${file} ${HOME}/${file}; done
}

function link_env_file() {
  basename=$(echo ${1} | \awk -F'/' '{print $NF}')
  \ln -fsv $(pwd)/${1} ${HOME}/${basename}
}

function install_env_files() {
  for file in envs/${1}/.*; do
    if [[ ! ${file} =~ \/\.{1,2}$ ]]; then link_env_file ${file}; fi
  done
}

env_type=""
while getopts ":lmw" opts; do
  case ${opts} in
    l ) env_type="linux";;
    m ) env_type="mac";;
    w ) env_type="win";;
    \? ) goto_error;;
  esac
done
shift $(expr ${OPTIND} - 1)
if [ -z ${env_type} ]; then goto_error; fi

install_common_files
install_env_files ${env_type}
echo "OK"

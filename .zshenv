zcompile ~/.zshenv
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
source ~/.zshenv.d/zsh-syntax-highlighting.zsh

### Autoload
autoload -Uz add-zsh-hook
autoload -Uz colors     ; colors
autoload -Uz compinit   ; compinit
autoload -Uz is-at-least
autoload -U  promptinit ; promptinit
autoload -Uz vcs_info

### General
bindkey -e
setopt always_last_prompt
setopt auto_name_dirs
setopt auto_resume
setopt brace_ccl
setopt bsd_echo
setopt cdable_vars sh_word_split
setopt extended_glob
setopt hash_cmds
setopt long_list_jobs
setopt magic_equal_subst
setopt multios
setopt no_beep
setopt no_clobber
setopt no_flow_control
setopt no_hup
setopt notify
setopt numeric_glob_sort
setopt path_dirs
setopt print_eight_bit
setopt short_loops

### Completion ###
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' use-cache true
zstyle ':completion:*:processes' command 'ps x'
setopt auto_remove_slash
setopt auto_param_slash
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt list_packed
setopt list_types
setopt complete_in_word
setopt mark_dirs
setopt no_menu_complete

### Directory ###
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_to_home
setopt pushd_silent

### History ###
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt share_history

### Show vcs branch name ###
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "C"
  zstyle ':vcs_info:git:*' unstagedstr "U"
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi
function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

### Alias/Export/PATH ###
alias e="exit"
alias be="bundle exec"
alias v="vim"
alias b2d="boot2docker"

function p() {
  $* | peco
}
function peco_select_history() {
    typeset tac
    if which tac > /dev/null; then
        tac=tac
    else
        tac='tail -r'
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
function tex2bpdf() {
  platex $1 && \
  bibtex $1 && \
  platex $1 && \
  platex $1 && \
  dvipdfmx $1 && \
  open $1.pdf &
}
function tex2pdf() {
  platex $1 && \
  dvipdfmx $1 && \
  open $1.pdf &
}


# EDITOR
export EDITOR="vim"

# PAGER
export PAGER="less"
export LESS="--RAW-CONTROL-CHARS"

# PATH
typeset -U path
path=(\
  /usr/local/bin \
  /usr/sbin \
  /usr/bin \
  /sbin \
  /bin \
  )

# golang
if [ -e $HOME/gopath ]; then
  export GOPATH=$HOME/gopath
  export GOROOT=/usr/local/opt/go/libexec
  export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
fi
if [ -e $GOPATH/bin/peco ]; then
  zle -N peco_select_history
  bindkey '^r' peco_select_history
fi

# plenv
if [ -e $HOME/.plenv ]; then
  export PERL_CPANM_OPT="--local-lib=~/perl5"
  export PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB"
  export PATH="$HOME/.plenv/bin:$HOME/.plenv/shims:$PATH:$HOME/perl5/bin"
  eval "$(plenv init -)"
fi

# pyenv
if [ -e $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"
  eval "$(pyenv init -)"
fi

# rbenv
if [ -e $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

# tex
if [ -e /usr/texbin ]; then
  export PATH="/usr/texbin:$PATH"
fi

### Environment settings ###
source ~/.zshrc.env


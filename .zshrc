zcompile ~/.zshrc
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
export WORDCHARS='~!#$%^&()-_=[]{}<>?'
source ~/.zsh.d/zsh-syntax-highlighting.zsh


### Autoload
autoload -Uz colors     ; colors
autoload -Uz compinit   ; compinit
autoload -Uz promptinit ; promptinit
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz vcs_info


### General
bindkey -e
setopt always_last_prompt
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_name_dirs
setopt auto_param_slash
setopt auto_param_keys
setopt auto_pushd
setopt auto_remove_slash
setopt auto_resume
setopt brace_ccl
setopt bsd_echo
setopt complete_in_word
setopt cdable_vars sh_word_split
setopt extended_glob
setopt hash_cmds
setopt ignoreeof
setopt list_packed
setopt list_types
setopt long_list_jobs
setopt magic_equal_subst
setopt mark_dirs
setopt multios
setopt no_beep
setopt no_clobber
setopt no_flow_control
setopt no_hup
setopt no_menu_complete
setopt notify
setopt numeric_glob_sort
setopt path_dirs
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushd_to_home
setopt pushd_silent
setopt short_loops
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' use-cache true
zstyle ':completion:*:processes' command 'ps aux'


### History ###
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt append_history
setopt extended_history
setopt hist_expand
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history


### VCS ###
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:*' formats '(%s)-[%b]' '%m'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '-'
function _precmd_vcs_info () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  if [[ -z ${vcs_info_msg_0_} ]]; then
    psvar[1]=""
    psvar[2]=""
    psvar[3]=""
  else
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]=( "${vcs_info_msg_0_}" )
    [[ -n "$vcs_info_msg_1_" ]] && psvar[2]=( "${vcs_info_msg_1_}" )
    [[ -n "$vcs_info_msg_2_" ]] && psvar[3]=( "${vcs_info_msg_2_}" )
  fi
}
add-zsh-hook precmd _precmd_vcs_info


# functions
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
path=(\
  $HOME/opt/bin
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

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# rust
export PATH="$HOME/.cargo/bin:$PATH"
export RUST_SRC_PATH="$HOME/.cargo/rustc/src"

# Docker
#eval $(docker-machine env)

# Remove overlapped path
typeset -U path PATH
typeset -U manpath MANPATH

# aliases
alias cp='\cp -i'
alias mv='\mv -i'
alias rm='\rm -i'
alias e="exit'
alias be="bundle exec'
alias gl='cd $(ghq list -p | peco)'
alias nv="nvim'

### Environment settings ###
source ~/.zshrc.env

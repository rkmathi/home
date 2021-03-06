#### Initialize
zcompile $HOME/.zshrc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export WORDCHARS='~!#$%^&()_[]{}<>?'
source $HOME/.zsh.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


### Autoload
autoload -Uz add-zsh-hook
autoload -Uz colors; colors
autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
autoload -Uz vcs_info


### General
bindkey -e
setopt always_last_prompt
unsetopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_name_dirs
setopt auto_param_slash
setopt auto_param_keys
setopt auto_pushd
unsetopt auto_remove_slash
setopt auto_resume
setopt brace_ccl
setopt bsd_echo
setopt cdable_vars
setopt complete_in_word
unsetopt correct
unsetopt correct_all
setopt extended_glob
setopt function_argzero
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
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:processes' command 'ps aux'


### History
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=10000
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
setopt share_history


### VCS
if type git > /dev/null 2>&1; then
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' formats '(%s)-[%b]' '%m'
  zstyle ':vcs_info:*' get-revision true
  zstyle ':vcs_info:*' max-exports 3
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u'
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
fi


### Functions
if type peco > /dev/null 2>&1; then
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
  zle -N peco_select_history
  bindkey '^r' peco_select_history
fi


### Variables
# EDITOR
export EDITOR="vi"

# PAGER
export PAGER="less"
export LESS="--RAW-CONTROL-CHARS"

# PATH
typeset -U path PATH
typeset -U manpath MANPATH
path=( \
  $HOME/opt/bin \
  /usr/local/sbin \
  /usr/local/bin \
  /usr/sbin \
  /usr/bin \
  /sbin \
  /bin \
)

# REPORTTIME
export REPORTTIME=5

# cargo
if [ -e $HOME/.cargo ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# go
if [ -e $HOME/go ]; then
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH
  #export PATH=$GOPATH/bin:/opt/go/bin:$PATH
fi

# nodenv
if [ -e $HOME/.nodenv ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

# plenv
if [ -e $HOME/.plenv ]; then
  export PATH="$HOME/.plenv/bin:$PATH"
  eval "$(plenv init - zsh)"
fi

# pyenv
if [ -e $HOME/.pyenv ]; then
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# rbenv
if [ -e $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi


### Aliases
alias be='bundle exec'
alias bt='batcat --color=always --paging=never --style="changes,numbers,snip" --theme=GitHub'
alias e='exit'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dce='docker-compose exec'
alias dcu='docker-compose up'
alias dcp='docker-compose ps'
alias dcr='docker-compose run --rm'
alias doe='docker exec -it'
alias doi='docker image'
alias dois='docker images'
alias dop='docker ps'
alias dopa='docker ps -a'
alias nv='nvim'
alias t='tmux -f ~/.tmux.conf'
alias v='vim'


### Environment settings
if [ -e $HOME/.zshrc.env ]; then
  source $HOME/.zshrc.env
fi
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

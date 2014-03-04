zcompile ~/.zshrc
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# EDITOR
export EDITOR="vim"

# PAGER
export PAGER="less"
export LESS='--RAW-CONTROL-CHARS'

# PATH
typeset -xT PYTHONPATH python_path
typeset -U python_path
python_path=( \
    ./lib)

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=( \
    {,/usr,/usr/local}/sbin)

typeset -U path
path=(\
    $HOME/opt/bin \
    /opt/bin \
    /usr/local/bin \
    /usr/bin \
    /bin \
)

### Environment ###
source ~/.zshrc.env


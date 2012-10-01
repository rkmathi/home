export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=screen-256color
zcompile ~/.zshrc
source ~/.zsh/zsh-syntax-highlighting.zsh

##========================================================##
##=================== Prompt settings ====================##
##========================================================##
bindkey -e
autoload -U  promptinit ; promptinit
autoload -Uz colors     ; colors

# Show branch name in Zsh's right prompt
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
autoload -Uz is-at-least
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

case ${UID} in
    0)
        PROMPT="
%{$reset_color%}# "
        PROMPT="%{$reset_color%}[%{$fg[grey]%}%B%~%b%{$reset_color%}] %1(v|%F{blue}%1v%f|)$PROMPT"
        PROMPT="%{$reset_color%}%{$fg[red]%}$USER%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}$PROMPT"
        ;;
    *)
        PROMPT="
%{$reset_color%}$ "
        PROMPT="%{$reset_color%}[%{$fg[grey]%}%B%~%b%{$reset_color%}] %1(v|%F{blue}%1v%f|)$PROMPT"
        PROMPT="%{$reset_color%}%{$fg[green]%}$USER%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}$PROMPT"
        ;;
esac


##========================================================##
##================== Completion settings =================##
##========================================================##
autoload -Uz compinit ; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' use-cache true
zstyle ':completion:*:processes' command 'ps x'
setopt list_packed
setopt auto_remove_slash
setopt auto_param_slash
setopt mark_dirs
setopt list_types
unsetopt menu_complete
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_resume


##========================================================##
##==================== Predict settings ==================##
##========================================================##
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey '^xp'  predict-on
bindkey '^x^p' predict-off


##========================================================##
##=================== History settings ===================##
##========================================================##
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt append_history
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand


##========================================================##
##================== Directory settings ==================##
##========================================================##
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_to_home
setopt pushd_silent


##========================================================##
##==================== Other settings ====================##
##========================================================##
setopt no_beep
setopt complete_in_word
setopt extended_glob
setopt brace_ccl
setopt equals
setopt numeric_glob_sort
setopt path_dirs
setopt print_eight_bit
setopt auto_name_dirs
unsetopt flow_control
setopt no_flow_control
setopt hash_cmds
setopt bsd_echo
setopt no_hup
setopt notify
setopt long_list_jobs
setopt magic_equal_subst
setopt multios
setopt short_loops
setopt always_last_prompt
setopt cdable_vars sh_word_split
setopt rm_star_wait
unsetopt no_clobber
limit coredumpsize 0

# less
LESS=-r

# Alias
alias e='exit'
alias t='tmux -f ~/.tmux.conf'
alias be="bundle exec"
alias ck='../cake/console/cake'
alias updagrade="eix-sync -q;\
    emerge -qavuDN @world;\
    dispatch-conf;\
    emerge -avuDN @preserved-rebuild;\
    dispatch-conf;\
    eselect news read;"


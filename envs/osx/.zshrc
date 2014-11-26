### Prompt
case ${UID} in
    0)
        PROMPT="
%{$reset_color%}# "
        PROMPT="%{$reset_color%}[%{$fg[grey]%}%B%~%b%{$reset_color%}] %1(v|%F{blue}%1v%f|)$PROMPT"
        PROMPT="%{$reset_color%}%{$fg[red]%}$USER%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}$PROMPT"
        ;;
    *)
        PROMPT="
%{$reset_color%}$ "
        PROMPT="%{$reset_color%}[%{$fg[grey]%}%B%~%b%{$reset_color%}] %1(v|%F{blue}%1v%f|)$PROMPT"
        PROMPT="%{$reset_color%}%{$fg[green]%}$USER%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}$PROMPT"
        ;;
esac


### Autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


### Alias
alias t='tmux -f ~/.tmux.conf'


function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='%{$fg[yellow]%}λ %m %{$fg[green]%}%c %{$fg[blue]%}$(git_prompt_info)%{$reset_color%}
$(virtualenv_info)%{$fg_bold[yellow]%}→ %{$reset_color%}'

RPROMPT='${return_status} $(git_prompt_status) %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%} + "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%} o "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} x "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%} » "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%} ═ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[green]%} * "

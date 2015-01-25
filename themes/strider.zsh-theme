function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo 'Hg' && return
    echo '○'
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='%{$fg[yellow]%}.::.%{$reset_color%} %{$fg_bold[white]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)%{$fg_bold[red]%}>>>%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='${return_status} $(git_prompt_status) %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} + "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} o "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} x "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} » "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%} * "

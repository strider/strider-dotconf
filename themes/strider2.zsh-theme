#!/usr/bin/env zsh

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo "(%{$fg[green]%}"`basename $VIRTUAL_ENV`"%{$fg_bold[blue]%}) "
}

function rbenv_info {
    if which rbenv &> /dev/null; then
        echo "(%{$fg[green]%}rbenv:$(rbenv version | sed -e "s/ (set.*$//")%{$fg_bold[blue]%}) "
    fi
}

setopt promptsubst

autoload -U add-zsh-hook
GIT_DIRTY_COLOR=$FG[124]
GIT_CLEAN_COLOR=$FG[148]
GIT_PROMPT_INFO=$FG[148]

# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}(✘)"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$GIT_CLEAN_COLOR%}(✔)"

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}═"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}✖"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}➜"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}✹"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}✭"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

PROMPT='%{$fg_bold[blue]%}$(virtualenv_info)%{$reset_color%}%{$fg_bold[blue]%}$(rbenv_info)%{$reset_color%}%{$fg_bold[magenta]%}.::.%{$reset_color%} %{$terminfo[bold]$FG[226]%}%c%{$reset_color%} %{$GREEN_BOLD%}$(git_current_branch)$(git_prompt_short_sha)$(git_prompt_status)%{$RESET_COLOR%}
%{$terminfo[bold]$FG[226]%}»%{$reset_color%} '

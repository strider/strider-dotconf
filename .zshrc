# => Path and Plugins {{{
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="strider2"

# Base16 Shell
#BASE16_SHELL="/home/gchamoul/.config/base16-shell/base16-tomorrow.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(themes git git-extras dnf tmux vagrant fasd docker colored-man-pages catimg ssh-agent gpg-agent pep8 zsh_reload colorize cp history history-substring-search systemd virtualenv virtualenvwrapper rbenv vi-mode pass gitignore github gitfast web-search)

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Vi mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
# add missing vim hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo

export KEYTIMEOUT=1

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa:~/.ssh/id_rsa_redhat"

# }}}
# => Exports {{{
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

unset GREP_OPTIONS
# }}}
# => History {{{
HISTFILE=~/.zsh/history
# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous
# event).
setopt hist_ignore_all_dups
# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous.
setopt hist_find_no_dups
# }}}
# => Options {{{
# Enable correction
setopt correct
# Do not query the user before executing rm * or rm path/*.
unsetopt rm_star_silent # Ask confirmation for 'rm *'
## Push
setopt pushd_silent
setopt pushd_to_home
## No beep
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
# }}}
# => Completion {{{
# If this option is set completions are shown only if the completions don't have
# an unambiguous prefix or suffix that could be inserted in the command line.
unsetopt list_ambiguous

# When the last character resulting from a completion is a slash and the
# next character typed is a word delimiter, remove the slash.
setopt auto_remove_slash

## cd
zstyle ':completion:*:cd:*' ignore-parents parent pwd

## Prevent to propose a item already prpose
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

## killall
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# ssh-agent
zstyle ':omz:plugins:ssh-agent' identities id_rsa id_rsa_redhat
# }}}
# => Aliases {{{

## Bad reflex correction
alias q!='echo $fg[red]Je ne suis pas dans VIM !$reset_color'
alias x!='echo $fg[red]Je ne suis pas dans VIM !$reset_color'

## Misc
alias dnf='sudo dnf'

alias v='f -e vim'
alias o='a -e xdg-open'
alias tmux="tmux -2"
alias tailf="tail -f"
alias gfa="git fetch --all"
alias grl="git review -l"
alias grd="git review -d"
alias fedsbr="fedpkg switch-branch"
alias cls="clear"
alias vla="sudo virsh list --all"
alias t='~/bin/todo.txt-cli/todo.sh -d /home/gchamoul/todo.cfg'
alias vv="virt-viewer -c qemu:///system"
alias hd='od -Ax -tx1z -v'
alias realpath='readlink -f'
alias makePassword='< /dev/urandom tr -dc A-Za-z0-9_ | head -c15 '
alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias httprc='python -c "import httplib,pprint; pprint.pprint(httplib.responses.items())"'
alias gertty_puppet='workon gertty-env && gertty -d --fetch-missing-refs -c ~/.gertty_puppet.yaml'
alias gertty_tripleo='workon gertty-env && gertty -d --fetch-missing-refs -c ~/.gertty_tripleo.yaml'
alias cal='cal -3'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias lh='ls -AdC .*'
alias l='ls -l'
alias ll='ls -l --group-directories-first --time-style=+"%d-%m-%Y %H:%M" --color=auto -F' # ls détaille
alias la='ls -lah --group-directories-first --time-style=+"%d-%m-%Y %H:%M" --color=auto -F' # ls aussi les fichiers cachés .*
alias lsofnames="lsof | awk '!/^\$/ && /\// { print \$9 }' | sort -u" # noms des fichiers ouverts
alias ls='ls --group-directories-first --time-style=+"%d-%m-%Y %H:%M" --color=auto -F'
alias cd..="cd .."
alias h='history'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias path='echo -e ${PATH//:/\\n}'
alias lsa='ls -ld .*'
alias lst="ls -ralt"
alias lsd="ls -ralt"
alias lss="ls -ralS"
alias vim='/usr/bin/vimx'
alias wiki='/usr/bin/vimx -c VimwikiIndex'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --color=auto'
alias tailf='tail -f'
alias rscp='rsync -aP --no-whole-file --inplace' # rsync cp // a(garder permissions) P(progress bar)
alias rsmv='rscp --remove-source-files' # rsync mv avec progressbar

alias ports="lsof -i -n -P" # Voir les process qui utilisent une connection internet
alias estab="ss -p | grep STA" # Voir seulement les sockets établis
alias netstat80="netstat -plan|grep :80|awk {'print $5'}|cut -d: -f 1|sort|uniq -c|sort -nk 1" # nombre de connections sur le port 80 du serveur par IP
alias openports="netstat -nape --inet" # Voir les ports ouverts
alias netpid="netstat -tlnp" # Voir le port qui écoute avec le PID du process associé
alias appson="netstat -lantp | grep -i stab | awk -F/ '{print $2}' | sort | uniq" # Voir une liste des noms de process qui utilisent une connection
alias calc='python -ic "from math import *; from random import *"' # Une calculatrice en python

alias my_ip="dig +short myip.opendns.com @resolver1.opendns.com"

# View HTTP traffic
alias sniff="sudo ngrep -d 'wlp3s0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i wlp3s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# translate via google-translation-cli
alias trs2fr="/usr/bin/trs {en=fr} "
alias trs2en="/usr/bin/trs {fr=en} "

alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'

# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

alias sc='xrandr --output LVDS1 --auto --rotate normal --pos 0x0 --output HDMI1 --auto --rotate normal --right-of LVDS1'
alias usc='xrandr --output HDMI1 --off'

# Gerrit stuffs
alias gerrit='ssh -p 29418 review.openstack.org gerrit'
alias pk-core-list='gerrit ls-members packstack-core'
alias pm-core-list='gerrit ls-members puppet-manager-core'
alias pk-add-reviewers='gerrit set-reviewers $(git rev-parse --short HEAD) --add ichavero --add mmagr --add xbezdick --add jpena'
alias pm-add-reviewers='gerrit set-reviewers $(git rev-parse --short HEAD) --add ichavero --add mmagr --add xbezdick --add jpena --add sbadia --add emilienm --add krinkle --add mfisch'

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias zrc="source ~/.zshrc"
alias vcon="~/bin/gentoken.sh --vpn-connect"
alias rpt='bundle exec rake spec SPEC_OPTS="--color --format documentation --profile 10"'
# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
# }}}
# => Misc {{{
export LIBVIRT_DEFAULT_URI=qemu:///system
export WORKON_HOME=$HOME/.virtualenvs
source ~/.local/bin/virtualenvwrapper.sh
export VAGRANT_DEFAULT_PROVIDER=libvirt
export EDITOR='vim'

export PATH=$PATH:$HOME/.local/bin
export PYTHONPATH=$HOME/.local/lib/python2.7/site-packages

eval "$(fasd --init auto)"
source ~/.github-auth
eval "$(hub alias -s)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
export GOPATH=$HOME/.gotools

xrdb ~/.Xresources
stty -ixon
# }}

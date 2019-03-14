#!/bin/zsh
# Bindings
bindkey '^r' history-incremental-search-backward
bindkey -a u undo
bindkey -a '^R' redo

# fkill - kill process
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Alias
## Bad reflex correction
alias q!='echo $fg[red]Je ne suis pas dans VIM !$reset_color'
alias x!='echo $fg[red]Je ne suis pas dans VIM !$reset_color'

alias v='f -e vim'
alias o='a -e xdg-open'
alias tmux="tmux -2"
alias mutt="neomutt"
alias tailf="tail -f"
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias ts='tmux new-session -s'
alias tenv='mosh gchamoul@krav -- tmux attach-session -t tripleo'
alias g="git"
alias gbr="git branch --all"
alias gfa="git fetch --all"
alias grl="git review -l"
alias grd="git review -d"
alias grx="git review -x"
alias gcl="git config -l"
alias fedsbr="fedpkg switch-branch"
alias vla="sudo virsh list --all"
alias t='/usr/local/bin/todo.sh -d /home/gchamoul/todo.cfg'
alias vv="virt-viewer -c qemu:///system"
alias hd='od -Ax -tx1z -v'
alias realpath='readlink -f'
alias makePassword='< /dev/urandom tr -dc A-Za-z0-9_ | head -c15 '
alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias httprc='python -c "import httplib,pprint; pprint.pprint(httplib.responses.items())"'
alias cal='cal -3'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias lsofnames="lsof | awk '!/^\$/ && /\// { print \$9 }' | sort -u" # noms des fichiers ouverts
alias mount='mount |column -t'
alias cd..="cd .."
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias lh='ls -AdC .*'
alias lsa='ls -ld .*'
alias lst="ls -ralt"
alias lsd="ls -ralt"
alias lss="ls -ralS"
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

unalias e
unalias vim
unalias vi

#alias e="vimx"
alias vim="vimx"
alias vi="vimx"

alias wiki='vimx -c VimwikiIndex'
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
alias sniff="sudo ngrep -d 'wlp58s0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i wlp58s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# translate via google-translation-cli
alias trs2fr="~/bin/trs {en=fr} "
alias trs2en="~/bin/trs {fr=en} "

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

# Gerrit stuffs
alias gerrit='ssh -p 29418 review.openstack.org gerrit'
alias pk-core-list='gerrit ls-members packstack-core'
alias pm-core-list='gerrit ls-members puppet-manager-core'
alias oooq-add-reviewers='gerrit set-reviewers $(git rev-parse --short HEAD) --add adarazs@redhat.com --add gcerami@redhat.com --add trown@redhat.com --add rlandy@redhat.com --add sshnaidm@redhat.com --add weshayutin@gmail.com'

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias ftd='find . -type d -name'
alias ftf='find . -type f -name'

alias qq="cd . && source ~/.zshrc"
alias vcon="~/bin/gentoken.sh --vpn-connect"

alias keys="ssh-add ~/.ssh/id_rsa_redhat ~/.ssh/id_rsa"

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

alias -g G='| grep '
alias -g C='| wc -l'
alias -g L='| less'

alias dnfl="dnf list"
alias dnfli="dnf list installed"
alias dnfgl="dnf grouplist"
alias dnfmc="dnf makecache"
alias dnfp="dnf info"
alias dnfs="dnf search"

alias dnfu="sudo dnf upgrade -y"
alias dnfi="sudo dnf install"
alias dnfgi="sudo dnf groupinstall"
alias dnfr="sudo dnf remove"
alias dnfgr="sudo dnf groupremove"
alias dnfc="sudo dnf clean all"

export LIBVIRT_DEFAULT_URI=qemu:///system
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper_lazy.sh
export VAGRANT_DEFAULT_PROVIDER=libvirt

#source $HOME/.zsh/agnoster.zsh-theme

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

eval "$(fasd --init auto)"
source ~/.github-auth
eval "$(hub alias -s)"

source ~/bin/forgit/forgit.plugin.zsh

export EDITOR="emacs"
export VISUAL="emacs"

# alias emacs="$EMACS_PLUGIN_LAUNCHER --no-wait "
alias e=emacs
alias te="emacs -nw"
# open terminal emacsclient
alias tec="emacsclient -nw"
# create a new X frame
alias eframe='emacsclient --alternate-editor "" --create-frame'

# Show grep results in white text on a red background
export GREP_COLOR='1;37;41'
HISTSIZE=100000000
SAVEHIST=${HISTSIZE}

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--no-reverse --no-height'
export FZF_TMUX=1
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--sort --preview 'echo {}' --preview-window down:3:hidden --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.local/bin:$HOME/bin/git-config/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
/usr/bin/stty -ixon

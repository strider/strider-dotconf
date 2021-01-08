#!/bin/zsh
# Bindings
bindkey '^r' history-incremental-search-backward
bindkey -a u undo
bindkey -a '^R' redo

function _web_search() {
    emulate -L zsh

    # define search engine URLS
    typeset -A urls
    urls[google]="https://www.google.com/search?q="
    urls[duckduckgo]="https://www.duckduckgo.com/?q="
    urls[startpage]="https://www.startpage.com/do/search?q="
    urls[github]="https://github.com/search?q="
    urls[rhbz]="https://bugzilla.redhat.com/show_bug.cgi?id="

    # check whether the search engine is supported
    if [[ -z "${urls[$1]}" ]]; then
        echo "Search engine $1 not supported."
        return 1
    fi

    # search or go to main page depending on number of arguments passed
    if [[ $# -gt 1 ]]; then
        # build search url:
        # join arguments passed with '+', then append to search engine URL
        # shellcheck disable=SC2154
        url="${urls[$1]}${(j:+:)@[2,-1]}"
    else
        # build main page url:
        # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
        # shellcheck disable=SC2154
        url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
    fi

    xdg-open "$url"
    return 0
}

function web_search() {
    _web_search "$@"
}
alias google='web_search google'
alias ddg='web_search duckduckgo'
alias sp='web_search startpage'
alias github='web_search github'
alias rhbz='web_search rhbz'

# bangs
alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias youtube='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'

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
alias v='f -e tec'
alias o='a -e xdg-open'
alias c='pygmentize -g'
alias mux="tmuxinator"
alias tmux="tmux -2"
alias mutt="neomutt"
alias tailf="tail -f"
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias ts='tmux new-session -s'
alias tenv='mosh gchamoul@krav -- tmux new -A -s tripleo'
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
alias webshare='python3 -m http.server 8000'
alias httprc='python2 -c "import httplib,pprint; pprint.pprint(httplib.responses.items())"'
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
alias gerrit='ssh -p 29418 review.opendev.org gerrit'
alias pk-core-list='gerrit ls-members tripleo-core'
#alias oooq-add-reviewers='gerrit set-reviewers $(git rev-parse --short HEAD) --add adarazs@redhat.com --add gcerami@redhat.com --add trown@redhat.com --add rlandy@redhat.com --add sshnaidm@redhat.com --add weshayutin@gmail.com'

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
source ~/.local/bin/virtualenvwrapper.sh
export VAGRANT_DEFAULT_PROVIDER=libvirt

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

eval "$(fasd --init auto)"
source ~/.github-auth
eval "$(hub alias -s)"

source ~/bin/forgit/forgit.plugin.zsh

export EDITOR="emacsclient -c --no-wait"
export VISUAL="emacsclient -c --no-wait"
export GTAGSLABEL=ctags

# alias emacs="$EMACS_PLUGIN_LAUNCHER --no-wait "
alias e="emacsclient -c --no-wait '$@'"
alias te="emacs -nw"
# open terminal emacsclient
alias tec="emacsclient -nw"
# create a new X frame
alias eframe='emacsclient -c --no-wait "$@"'

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

export PATH="$PATH:$HOME/.local/bin:$HOME/bin/git-config/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

/usr/bin/stty -ixon

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

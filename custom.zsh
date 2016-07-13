# Bindings
bindkey '^r' history-incremental-search-backward
bindkey -a u undo
bindkey -a '^R' redo

# Alias
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
alias lsofnames="lsof | awk '!/^\$/ && /\// { print \$9 }' | sort -u" # noms des fichiers ouverts
alias cd..="cd .."
alias h='history'
alias cd..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias lsa='ls -ld .*'
alias lst="ls -ralt"
alias lsd="ls -ralt"
alias lss="ls -ralS"
alias vim='/usr/bin/vimx'
alias wiki='/usr/bin/vimx -c VimwikiIndex'
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

alias dnfl="dnf list"                       # List packages
alias dnfli="dnf list installed"            # List installed packages
alias dnfgl="dnf grouplist"                 # List package groups
alias dnfmc="dnf makecache"                 # Generate metadata cache
alias dnfp="dnf info"                       # Show package information
alias dnfs="dnf search"                     # Search package

alias dnfu="dnf upgrade"               # Upgrade package
alias dnfi="dnf install"               # Install package
alias dnfgi="dnf groupinstall"         # Install package group
alias dnfr="dnf remove"                # Remove package
alias dnfgr="dnf groupremove"          # Remove package group
alias dnfc="dnf clean all"             # Clean cache

export LIBVIRT_DEFAULT_URI=qemu:///system
export WORKON_HOME=$HOME/.virtualenvs
source ~/.local/bin/virtualenvwrapper.sh
export VAGRANT_DEFAULT_PROVIDER=libvirt

export PATH=$PATH:$HOME/.local/bin
export PYTHONPATH=$HOME/.local/lib/python2.7/site-packages

eval "$(fasd --init auto)"
source ~/.github-auth
eval "$(hub alias -s)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
stty -ixon
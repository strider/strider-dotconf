#!/bin/bash

alias xsos="/home/gchamoul/bin/xsos"
alias tmux="TERM=xterm-256color tmux -2"
alias gpa="~/bin/gpa"
alias yed="java -jar ~/bin/yed-3.11.1/yed.jar"
alias xmind="~/bin/xmind/XMind_Linux_64bit/XMind"
alias cls="clear"
alias vla="sudo virsh list --all"
alias t='todo.sh -d /home/gchamoul/todo.cfg'
alias vv="virt-viewer -c qemu:///system"
alias hd='od -Ax -tx1z -v'
alias v='/usr/bin/vimx'
alias realpath='readlink -f'
alias xterm="xterm +sb -bg black -fg white -fa Consolas -fs 13"
alias makePassword='< /dev/urandom tr -dc A-Za-z0-9_ | head -c15 '
alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias httprc='python -c "import httplib,pprint; pprint.pprint(httplib.responses.items())"'
alias dl='cd $HOME/Downloads'
alias dev='cd $HOME/Documents/DEV'
alias fr='cd $HOME/Documents/002_CONSULTING/Customers/FRANCE/'
alias fopdf='$HOME/Documents/DEV/ASCIIDOC/asciidoctor-fopdf/./fopdf'
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
alias j='jobs -l'
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
alias vb='/usr/bin/vimx ~/.bashrc; source ~/.bashrc'
alias sls='screen -ls'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --color=auto'
alias pdoc='screen -t \"Python Documentation\" w3m /usr/share/doc/python-docs-2.7.1/html/index.html'
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

bind '"\C-l"':"\"clear\r\"" # Ctrl+l vide le terminal
alias my_ip="dig +short myip.opendns.com @resolver1.opendns.com"

if type -P htop >/dev/null; then
  alias top='htop' # toujours utiliser htop si installé
fi

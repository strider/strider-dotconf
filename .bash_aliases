#!/bin/bash

alias tmux="TERM=xterm-256color tmux -2"
alias yed="java -jar ~/bin/yed-3.11.1/yed.jar"
alias xmind="~/bin/xmind/XMind_Linux_64bit/XMind"
alias cls="clear"
alias vla="sudo virsh list --all"
alias gmail="mutt -F ~/.muttrc_gmail"
alias t='todo.sh -d /home/gchamoul/todo.cfg'
alias vv="virt-viewer -c qemu:///system"
alias hd='od -Ax -tx1z -v'
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
alias ll='ls -l'
alias ls='ls -l -G -h -p --color'
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

## Pipe Aliases (Global)
alias L='|less'
alias G='|grep'
alias T='|tail'
alias H='|head'

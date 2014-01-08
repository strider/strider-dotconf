#!/bin/bash

# myip - Obtenir IP publique
# usage: myip
myip(){ wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//';}

# Créer une archive pour un repertoire donne.
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

###   Handy Extract Program
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# clock - Affiche une horloge simple
# usage: clock
clock() { while true;do clear;echo -e "\e[30;1m===========\e[0m\e[01;33m";date +"%r";echo -e "\e[0m\e[30;1m===========\e[0m";sleep 1;done; }

strerro() {
    python -c "import os; print os.strerror($1)";
}

revim() {
    vim scp://root@$1/$2
}

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working  directory clean)" ]] && echo "*"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/*\(.*\)/[\1$(parse_git_dirty)]/"
}

# make and change to a directory
md () { mkdir -p "$1" && cd "$1"; }

function encode() { echo -n $@ | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'; }
function google() { firefox http://www.google.com/search?hl=en#q="`encode $@`" ;}
function amazon() { firefox http://www.amazon.com/s/ref=nb_ss?field-keywords="`encode $@`" ;}
function wkp() { firefox http://en.wikipedia.org/w/index.php?search="`encode $@`" ;}

# Displays various types of documentation.
function doc() {
    case "$1" in
    python)
        tmux new-window -n "Python Documentation" 'w3m /usr/share/doc/python-docs-2.7.*/html/index.html' ;;
    esac
}

# XXX - mise en forme des permissions symbolic en octal (644)
# usage : ls -l | XXX
XXX() { sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g'  -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g' ; }

# cbt - Count by Type - affiche le nombre de fichiers par type
# usage : cbt
cbt() { find ${*-.} -type f -print0 | xargs -0 file | awk -F, '{print $1}' | awk '{$1=NULL;print $0}' | sort | uniq -c | sort -nr ;}

# Renomme en minuscules
# usage tolowercase <*.txt>
toLowercase() { for i in "$@"; do mv -f "$i" "`echo $i| tr [A-Z] [a-z]`" &>/dev/null; done }
 
# Renomme en majuscules
# usage toupercase <*.txt>
toUpercase() { for i in "$@"; do mv -f "$i" "`echo $i| tr [a-z] [A-Z]`" &>/dev/null; done }

# remplacer les espaces par des _
# usage underscorespace <*.txt>
underscorespace() { for i in "$@"; do mv "$i" "`echo $i| tr ' ' '_'`" &>/dev/null; done }

# tempsrep - temps de réponse pour un URL
# usage : tempsrep <URL> (TTFB:time to first bit)
tempsrep() { curl -o /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" $1; }

# getserver - Determine le serveur utilisé par un site 
# usage : getserver <URL> 
getserver() { curl -I $1  2>&1 | grep Server;}

#!/bin/bash

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
    llvm)
        screen -t ‘LLVM Documentation’ w3m /usr/share/doc/llvm-doc/html/index.html ;;
    python)
        screen -t ‘Python Documentation’ /usr/bin/w4m /usr/share/doc/python-docs-2.7.1/html/index.html ;;
    git)
        screen -t ‘Git Documentation’ w3m /usr/local/share/doc/git-doc/index.html ;;
    sqlite)
        screen -t ‘SQLite Documentation’ w3m /usr/share/doc/sqlite3-doc/index.html ;;
    django)
        screen -t ‘Django Documentation’ w3m /usr/share/doc/python-django-doc/html/index.html ;;
    esac
}

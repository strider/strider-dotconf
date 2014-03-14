# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export PATH=$PATH:~/bin
export TERM=screen-256color
export ANSIBLE_HOSTS=~/ansible_hosts
#export PAGER="/usr/bin/less -X"
source ~/bin/.git-completion.bash
source ~/bin/.git-prompt.sh
source ~/bin/todo.txt-cli/todo_completion
complete -F _todo t

export HISTIGNORE="&:ls:cd:ll:la:ping:exit"
export HISTFILESIZE="30000"
export HISTTIMEFORMAT="%D %H:%M "
export HISTCONTROL=ignoreboth
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \ "$(history 1)" >> ~/.bash_permanent_history'
export CDPATH=".:~:~Documents:~Documents/DEV"
export EDITOR="vimx"

set -o vi
set -o notify

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

shopt -s cdspell
shopt -s dirspell
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# import some functions 
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

#if [ -f ~/.bash_prompt ]; then
#    . ~/.bash_prompt
#fi

source ~/.bash-git-prompt/gitprompt.sh

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export LANG="en_US.UTF-8"

# ensure ssh agent is started.
# `$ ssh-add -L`: check if keys are already upload or load them using the same command.
# `$ ssh-add -D`: destroy your keys
# thanks to http://drupal.star.bnl.gov/STAR/blog-entry/jeromel/2009/feb/06/how-safely-start-ssh-agent-bashrc
test=`/bin/ps -ef | /bin/grep ssh-agent | /bin/grep -v grep  | /usr/bin/awk '{print $2}' | xargs`

if [ "$test" = "" ]; then
   # there is no agent running
   if [ -e "$HOME/agent.sh" ]; then
      # remove the old file
      /bin/rm -f $HOME/agent.sh
   fi;
   # start a new agent
   /usr/bin/ssh-agent | /bin/grep -v echo >&$HOME/agent.sh 
fi;

test -e $HOME/agent.sh && source $HOME/agent.sh

alias kagent="kill -9 $SSH_AGENT_PID"

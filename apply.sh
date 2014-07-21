#!/bin/bash

output() {
    echo -e ""
    echo -e "\e[30;48;5;82m-- $@\e[0m"
}

output "Applying TMUX configuration"
cp -vf .tmux.conf ~/.tmux.conf

output "Applying BASH configuration"
cp -vf .bash* ~/

output "Applying GIT configuration"
cp -vf .gitconfig ~/
rm -Rf ~/.bash-git-prompt/
cp -rvf .bash-git-prompt/ ~/
rm -Rf ~/.git-prompt-colors.sh
cp -vf .git-prompt-colors.sh ~/

output "Applying GERRYMANDER configuration"
cp -vf .gerrymander ~/

output "Applying X configuration"
cp -vf .Xresources ~/


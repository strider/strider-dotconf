#!/bin/bash

output() {
    echo -e ""
    echo -e "\e[30;48;5;82m-- $@\e[0m"
}

output "Applying ZSH configuration"
rm -Rf ~/.oh-my-zsh/
cp -rvf .oh-my-zsh/ ~/
cp -rvf themes/ ~/.oh-my-zsh/custom/
cp -vf .zshrc ~/

output "Applying TMUX configuration"
cp -vf .tmux.conf ~/.tmux.conf

output "Applying ACK configuration"
cp -vf .ackrc ~/

output "Applying GIT configuration"
cp -vf .gitconfig ~/
cp -vf .tigrc ~/

output "Applying GERRYMANDER configuration"
cp -vf .gerrymander ~/

output "Applying VIMPERATOR configuration"
cp -vf .vimperatorrc ~/

output "Applying REDSHIFT configuration"
cp -vf redshift.conf ~/.config/

output "Applying X configuration"
cp -vf .Xresources ~/
cp -vf .dircolors ~/
cp -vf .motd ~/

xrdb ~/.Xresources

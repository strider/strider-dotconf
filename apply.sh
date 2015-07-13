#!/bin/bash

output() {
    echo -e ""
    echo -e "\e[30;48;5;82m-- $@\e[0m"
}

output "Applying ZSH configuration"
rm -Rf ~/.oh-my-zsh/
cp -rvf .oh-my-zsh/ ~/
rm -rvf ~/.oh-my-zsh/.git*
cp -rvf themes/ ~/.oh-my-zsh/custom/
cp -vf .zshrc ~/
cp -vf .mailcap ~/
cp -vf .gemrc ~/
cp -vf .fehbg ~/

output "ZATHURA configuration"
mkdir -p ~/.config/zathura
rm -Rf ~/.config/zathura/zathurarc
cp zathurarc ~/.config/zathura/zathurarc

output "Applying TMUX configuration"
cp -vf .tmux.conf ~/.tmux.conf

output "Installing fasd"
cd fasd/
PREFIX=$HOME make install
cd ..

output "Applying Puppet-lint configuration"
cp -vf .puppet-lint.rc ~/.puppet-lint.rc
cp -vf default-gems ~/

output "Applying ACK configuration"
cp -vf .ackrc ~/

output "Applying GIT configuration"
cp -vf .gitconfig ~/
cp -vf .tigrc ~/
cp -vf git-config/bin/* ~/bin/

output "Applying misc scripts"
cp -vf bin/* ~/bin/

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

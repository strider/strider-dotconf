#!/bin/bash

output() {
    echo -e ""
    echo -e "\e[30;48;5;82m-- $@\e[0m"
}

output "Applying ZSH configuration"
#rm -Rf ~/.oh-my-zsh/
#cp -rf .oh-my-zsh/ ~/
#rm -rf ~/.oh-my-zsh/.git*
#cp -rf themes/ ~/.oh-my-zsh/custom/
#cp -f .zshrc ~/
if [ -d ~/.zsh ]; then
    rm -Rf $HOME/.zsh/
    cp -rf zsh-config/ $HOME/.zsh
    cp -f custom.zsh $HOME/.zsh/
    ln -s $HOME/.zsh/zshrc $HOME/.zshrc
fi
cp -f .mailcap ~/
cp -f .gemrc ~/

output "ZATHURA configuration"
mkdir -p ~/.config/zathura
rm -Rf ~/.config/zathura/zathurarc
cp zathurarc ~/.config/zathura/zathurarc

output "Applying TMUX configuration"
cp -f .tmux.conf ~/.tmux.conf

output "Installing fasd"
cd fasd/
PREFIX=$HOME make install
cd ..

output "Applying Puppet-lint configuration"
cp -f .puppet-lint.rc ~/.puppet-lint.rc
cp -f default-gems ~/

output "Applying ACK configuration"
cp -f .ackrc ~/

output "Applying GIT configuration"
cp -f .gitconfig ~/
cp -f .tigrc ~/
cp -f git-config/bin/* ~/bin/

output "Applying misc scripts"
cp -f bin/* ~/bin/

output "Applying VIMPERATOR configuration"
cp -f .vimperatorrc ~/

output "Applying REDSHIFT configuration"
cp -f redshift.conf ~/.config/

output "Applying X configuration"
cp -f .Xresources ~/
#cp -f .dircolors ~/
cp -f .motd ~/

output "Applying Nodesets for beaker acceptance tests on Docker"
cp -rf nodesets/ ~/

xrdb ~/.Xresources

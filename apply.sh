#!/bin/bash

echo -e "Applying TMUX configuration\n"
cp -vf .tmux.conf ~/.tmux.conf

echo -e "Applying BASH configuration\n"
cp -vf .bash* ~/

echo -e "Applying GIT configuration\n"
cp -vf .gitconfig ~/

echo -e "Applying X configuration\n"
cp -vf .Xresources ~/

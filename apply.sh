#!/bin/bash

sudo dnf install vim-enhanced \
            scrot fasd hub ack \
            tmux wget curl net-tools \
            git-all git-review \
            python-virtualenvwrapper \
            python2-virtualenv \
            python3-virtualenv \
            python-pip python3-pip udiskie \
            tmuxinator zsh xdotool \
            stardict stardict-dic-en.noarch sdcv \
            calibre pwgen pdfmod acpi fslint \
            fontawesome-fonts rofi rofi-themes \
            light clipit mosh -y

if [ -d ~/.zsh ]; then
    rm -Rf $HOME/.zsh/
    cp -rf zsh-config/ $HOME/.zsh
    cp -f custom.zsh $HOME/.zsh/
    cp -f agnoster.zsh-theme $HOME/.zsh/
fi

if [ -f $HOME/.zshrc  ]; then
    rm -Rf $HOME/.zshrc
    ln -s $HOME/.zsh/zshrc $HOME/.zshrc
    echo "Reloading .zshrc"
    source ~/.zshrc
fi

if [ -d ~/.tmuxinator ]; then
    rm -Rf $HOME/.tmuxinator
    cp -rf .tmuxinator/ $HOME/
fi

cp -f .mailcap ~/
cp -f .gemrc ~/
mkdir -p ~/.config/zathura
rm -Rf ~/.config/zathura/zathurarc
cp zathurarc ~/.config/zathura/zathurarc
cp -f .tmux.conf ~/.tmux.conf
cp -f .puppet-lint.rc ~/.puppet-lint.rc
cp -f default-gems ~/
cp -f .ackrc ~/
cp -f .gitconfig ~/
cp -f .gitignore ~/
cp -f .tigrc ~/

if [ -d ~/bin/git-config ]; then
    rm -Rf ~/bin/git-config
    cp -rf git-config/ ~/bin/
else
    cp -rf git-config/ ~/bin/
fi
cp -f bin/* ~/bin/
cp -f .vimperatorrc ~/
cp -f .Xresources ~/
xrdb ~/.Xresources
cp -f .motd ~/
cp -rf nodesets/ ~/


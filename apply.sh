#!/bin/bash

sudo dnf install vim-enhanced \
            scrot hub ack \
            tmux wget curl net-tools \
            git-all git-review \
            python3-virtualenvwrapper \
            python3-virtualenv \
            python-pip python3-pip udiskie \
            zsh xdotool \
            stardict stardict-dic-en.noarch sdcv \
            calibre pwgen pdfmod acpi fslint \
            fontawesome-fonts rofi rofi-themes \
            light clipit mosh -y

if [ -d ~/.zsh ]; then
    rm -Rf $HOME/.zsh/
    cp -rf zsh-config/ $HOME/.zsh
    cp -f custom.zsh $HOME/.zsh/
    cp -f agnoster.zsh-theme $HOME/.zsh/
else
    cp -rf zsh-config/ $HOME/.zsh
    cp -f custom.zsh $HOME/.zsh/
    cp -f agnoster.zsh-theme $HOME/.zsh/
fi

if [ -f $HOME/.zshrc  ]; then
    rm -Rf $HOME/.zshrc
    ln -s $HOME/.zsh/zshrc $HOME/.zshrc
    echo "Reloading .zshrc"
    source ~/.zshrc
else
    ln -s $HOME/.zsh/zshrc $HOME/.zshrc
    echo "Reloading .zshrc"
    source ~/.zshrc
fi

if [ -d ~/.config/tmuxinator ]; then
    cp -rf .tmuxinator/*.yml $HOME/.config/tmuxinator/
else
    mkdir $HOME/.config/tmuxinator/
    cp -rf .tmuxinator/*.yml $HOME/.config/tmuxinator/
fi

if [ -d ~/.mutt ]; then
    cp -rf mutt/.muttrc $HOME/
    cp -rf mutt/gruvbox_colors $HOME/.mutt/
    cp -rf mutt/vim-keys.rc $HOME/.mutt/
    cp -rf mutt/gpg.rc $HOME/.mutt/
fi

cp -f .mailcap ~/
mkdir -p ~/.config/zathura
rm -Rf ~/.config/zathura/zathurarc
cp zathurarc ~/.config/zathura/zathurarc
cp -f .tmux.conf ~/.tmux.conf
cp -f .ackrc ~/
cp -f .gitconfig ~/
cp -f .gitignore ~/

if [ -d ~/bin/git-config ]; then
    rm -Rf ~/bin/git-config
    cp -rf git-config/ ~/bin/
else
    cp -rf git-config/ ~/bin/
fi
cp -f bin/* ~/bin/
cp -f .Xresources ~/
xrdb ~/.Xresources
cp -f .motd ~/

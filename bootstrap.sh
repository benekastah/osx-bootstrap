#!/bin/bash

LOCAL_DIR="$HOME/local"
mkdir -p "$LOCAL_DIR/bin"

TMP_DIR="/tmp/osx-bootstrap"
if [ -d "$TMP_DIR" ]; then
    sudo rm -rf "$TMP_DIR"
fi
mkdir -p "$TMP_DIR"

function install-todo-txt() {
    brew install todo-txt
    cp /usr/local/Cellar/todo-txt/2.9/todo.cfg ~/.todo.cfg    
}

function install-zsh() {
    brew install zsh
    if [ -z "`cat /etc/shells | grep "/usr/local/bin/zsh"`" ]; then
        sudo echo "/usr/local/bin/zsh" >> /etc/shells
    fi
}

function install-oh-my-zsh() {
    install-zsh

    if [ -d "$HOME/.oh-my-zsh" ]; then
        return 0
    fi
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
}

function install-iterm2() {
    install-wget

    local NAME="iTerm2_v1_0_0"
    local DOWNLOAD="http://iterm2.com/downloads/stable/iTerm2_v1_0_0.zip"
    local ITERM_ZIP="$TMP_DIR/$NAME.zip"
    local TMP_ITERM="$TMP_DIR/$NAME"

    wget "$DOWNLOAD" -O "$ITERM_ZIP"
    mkdir -p "$TMP_ITERM"
    unzip "$ITERM_ZIP" -d "$TMP_ITERM"
    mv "$TMP_ITERM/iTerm.app" /Applications
}


function install-watchdog() {
    pip install watchdog -U
}

function install-vdbi-reqs() {
    sudo cpanm DBI Plack JSON DBD::Pg
}

function install() {
    install-zsh
    install-oh-my-zsh
    install-iterm2
    install-todo-txt
    install-watchdog
}

function install-ubuntu() {
    install-watchdog
    sudo apt-get install cpanminus
    # For http://mattn.github.io/vdbi-vim/
    sudo cpanm DBI Plack JSON DBD::Pg
}

function _ln() {
    local src="`echo "$1" | sed 's@^\./@'$(pwd)'/@'`"

    # target is only used to determine which file to remove
    local target="`echo "$2" | sed 's@/$@@'`"
    if [ -d "$target" ]; then
        target="$target/`basename "$1"`"
    fi
    if [ -h "$target" ]; then
        rm "$target"
    fi

    ln -s "$src" "$2"
}

function link-dotfiles() {
    # Vim
    _ln ./dotfiles/vimrc ~/.vimrc
    mkdir -p ~/.vim
    for f in $(ls ./dotfiles/vim/*.vim); do
        _ln "$f" ~/.vim
    done

    # Zsh
    _ln ./dotfiles/zshrc ~/.zshrc

    # Bash
    _ln ./dotfiles/bashrc ~/.bashrc

    # Tmux
    _ln ./dotfiles/tmux.conf ~/.tmux.conf

    # Ctags
    _ln ./dotfiles/ctags ~/.ctags

    # Brewfile
    _ln ./dotfiles/brewinstall ~/.brewinstall
}

for arg in $@; do
    eval "$arg"
done

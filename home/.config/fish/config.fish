# Ensure homebrew installs take precedence over system installs
set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin

if test -d /usr/games
    set PATH $PATH /usr/games
end

set PATH ~/bin ~/local/bin $PATH

set HOMESHICK_FISH ~/.homesick/repos/homeshick/homeshick.fish
if test -e $HOMESHICK_FISH
    source $HOMESHICK_FISH
end

set -x EDITOR vim
set -x VISUAL

set -x GOPATH ~/.go
set PATH $PATH $GOPATH/bin
set -x GOROOT /usr/local/Cellar/go/1.2/libexec

set -x PYTHONUNBUFFERED 1
set -x PYTHONDONTWRITEBYTECODE 1

alias todo todo.sh
alias chrome "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome --remote-debugging-port=9222"
alias ssh-client-ip "echo \$SSH_CLIENT | awk '{print \$1}'"
alias info "\info --vi-keys"
alias rsed "sed -r"

function mdcd
    set d $argv[-1]
    mkdir $argv; and cd $d
end

if which keychain > /dev/null ^ /dev/null; then
    keychain $HOME/.ssh/id_rsa_bitbucket > /dev/null ^ /dev/null
    source "$HOME/.keychain/"(hostname)"-fish"
end

set HOSTFISH "$HOME/."(hostname)".fish"
if test -e $HOSTFISH
    source $HOSTFISH
end

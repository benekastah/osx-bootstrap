# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Ensure homebrew installs take precedence over system installs
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
if [ -d /usr/games ]; then
    export PATH="$PATH:/usr/games"
fi

# I like to have a ~/local/bin too
export PATH="$HOME/bin:$HOME/local/bin:$PATH"

# tmux
# Configure this before the plugins
# Wed Oct 22 14:39:20 PDT 2014 - I don't think this is right. It seems to be
# the thing causing my problems when using vim on tmux (characters will be mis-
# printed).
# alias tmux="TERM=screen-256color-bce \tmux -2"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pharp"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git tmux python pep8 pip brew fabric virtualenv)

# tmux
ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh
HOMESHICK_SH="$HOME/.homesick/repos/homeshick/homeshick.sh"
if [ -e "$HOMESHICK_SH" ]; then
    source "$HOMESHICK_SH"
fi

# User configuration

setopt histignorespace

# Check if the shell we are using is spawned from vim
if [ -n "$VIMRUNTIME" ]; then
    export RPROMPT="$RPROMPT"'$FG[238]vim%{$reset_color%}'
fi

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# I like vim
export EDITOR=vim
export VISUAL=

# Go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export GOROOT="/usr/local/Cellar/go/1.2/libexec"

# Vim keybindings
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# todo
alias todo="todo.sh"

# Chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222"

# Python
export PYTHONUNBUFFERED=1
export PYTHONDONTWRITEBYTECODE=1

# Chartio
alias handlebars-watch="watchmedo shell-command \
    --patterns=\"*.handlebars\" --recursive \
    --command=\"fab vagrant handlebars:/srv/sqlcharts\""

alias mutt="(cd ~/Downloads; \mutt)"

alias irssi=" \
    tmux split-window -h \"perl ~/.irssi/scripts/adv_windowlist.pl\" && \
    tmux swap-pane -D && \
    tmux resize-pane -t 1 -L -x 10 && \
    tmux select-pane -R && \
    \irssi && \
    tmux kill-pane -t 1"

alias ssh-client-ip="echo \$SSH_CLIENT | awk '{print \$1}'"

alias info="\info --vi-keys"

mdcd() {
    DIR="${@: -1}"
    mkdir "$@" && cd "$DIR"
}

castle-vim() {
    local BASE_DIR="$HOME/dev/chartio/chartio-castle"
    local PY_ARGS=(
        '+cd\ '"$BASE_DIR"
    )
    if [ -n "$1" ]; then
        PY_ARGS+='+e\ '"$1"
    fi

    local JS_ARGS=(
        '+tabe'
        '+lcd\ '"$BASE_DIR/assets/app/javascripts"
    )
    if [ -n "$2" ]; then
        JS_ARGS+='+e\ '"$2"
    fi

    local TPL_ARGS=(
        '+tabe'
        '+lcd\ '"$BASE_DIR/sqlcharts/templates"
    )
    if [ -n "$3" ]; then
        TPL_ARGS+='+e\ '"$3"
    fi

    local VIM_ARGS=($PY_ARGS $JS_ARGS $TPL_ARGS '+tabfirst')

    # echo vim "${(@)VIM_ARGS}"
    vim "${(@)VIM_ARGS}"
}

tmux-colors() {
    local i
    local j
    for i in {0..255}; do
        local END="\t"
        if [[ $(($i % 8)) == 0 ]]; then
            END="\n"
        fi
        for j in {0..$((3 - ${#i}))}; do
            END=" $END"
        done
        printf "\x1b[38;5;${i}mcolour${i}$END"
    done
}

if which keychain > /dev/null 2>&1; then
    keychain $HOME/.ssh/id_rsa_bitbucket > /dev/null 2>&1
    source $HOME/.keychain/$HOST-sh
fi

HOSTZSHRC="$HOME/.$HOST.zsh"
if [ -e "$HOSTZSHRC" ]; then
    source "$HOSTZSHRC"
fi

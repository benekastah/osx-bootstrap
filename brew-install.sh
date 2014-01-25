#!/bin/bash

if [ -z "`which brew`" ]; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

while read ln; do
    ln="`echo "$ln" | perl -ne 's/(?<!\\\)#.*$//; print;' | sed 's/\\\#/#/'`"
    if [ -n "$ln" ]; then
        cmd="brew install $ln"
        echo $cmd
        eval "$cmd"
        echo
    fi
done < ~/.brewinstall

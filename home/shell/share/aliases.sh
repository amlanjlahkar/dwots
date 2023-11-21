#!/bin/sh

alias ls="ls --color=never -F"
alias la="command ls --color=never -AlFh -D '%y-%m-%d %I:%M%p'"
alias rm="rm -iv"
alias cp="cp -Riv"
alias mv="mv -iv"
alias grep="grep --color=auto"
alias shrm="shred --size=2048K -uv"
alias se="sudoedit"
alias lg="ls | rg"
alias du="du -hsx"
alias -- -="cd -"
alias ad="pushd"
alias pd="popd"
alias q="exit"

alias usage="df -Hl"

alias vg="valgrind -q --leak-check=yes -s"

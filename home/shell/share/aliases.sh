#!/bin/sh

alias ls="ls --color=never -F"
alias la="ls --color=never -lAFh -D '%e %b %y %H:%M'"
alias rm="rm -iv"
alias cp="cp -p -Riv"
alias mv="mv -iv"
alias grep="grep --color=auto"
alias shrm="shred --size=2048K -uv"
alias df="df -Hl"
alias se="sudo -e"
alias lg="ls | rg"
alias du="du -hsx"
alias -- -="cd -"
alias ad="pushd"
alias pd="popd"
alias q="exit"

alias fcheck="fc-list : family style spacing | rg -i"

alias slide="presenterm"

#!/bin/sh

alias ls="ls -G -F"
alias la="ls -G -lAFh -D '%e %b %y %H:%M'"
alias rm="rm -iv"
alias cp="cp -p -Riv"
alias mv="mv -iv"
alias grep="grep --color=auto"
alias shrm="shred --size=2048K -zuv"
alias df="df -Hl"
alias se="sudo -e"
alias lg="ls | rg"
alias du="du -hsx"
alias -- -="cd -"
alias q="exit"

alias fcheck="fc-list : family style spacing | rg -i"

alias slide="presenterm"

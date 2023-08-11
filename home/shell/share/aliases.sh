#!/bin/sh

alias ls="ls --color=never -F"
alias la="ls --color=never --group-directories-first --time-style='+%y-%m-%d %I:%M%p' -AlFh"
alias rm="rm -iv"
alias cp="cp --preserve=all -Riv"
alias mv="mv -iv"
alias grep="grep --color=auto"
alias open="xdg-open"
alias shrm="shred --size=2048K -uv"
alias se="sudoedit"
alias lg="ls | rg"
alias du="du -hsx"
alias -- -="cd -"
alias ad="pushd"
alias pd="popd"
alias q="exit"

alias usage="df --sync -Hl"
alias fcheck="fc-list : family style spacing | rg -i"

alias vg="valgrind -q --leak-check=yes -s"
alias liwa="xwinwrap -ov -g 1366x768+0+0 -- mpv -wid WID --no-osc --loop-file \
    --player-operation-mode=cplayer --panscan=1.0 --no-audio"

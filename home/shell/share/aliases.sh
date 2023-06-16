#!/usr/bin/env bash
alias ls="ls --color=never --group-directories-first -F"
alias ll="ls --color=never --group-directories-first --time-style='+%y-%m-%d %I:%M%p' -lFGh"
alias la="ls --color=never --group-directories-first --time-style='+%y-%m-%d %I:%M%p' -AlFGh"
alias rm="rm -iv"
alias cp="cp --preserve=all -Riv"
alias mv="mv -iv"
alias tree="tree -n"
alias rg="rg --colors 'path:fg:blue' --colors 'match:fg:yellow' --colors 'line:fg:245'"
alias grep="grep --color=auto"
alias open="xdg-open"
alias shrm="shred --size=2048K -uv"
alias se="sudoedit"
alias lg="ls | rg"
alias -- -="cd -"
alias q="exit"

# utils
alias usage="df --sync -Hl"
alias fcheck="fc-list : family style spacing | rg -i"

# other
alias termcolors="curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash"
alias upmake="doas makewhatis -a"
alias updb="doas updatedb"
alias uptd="tldr --update"
alias vg="valgrind --leak-check=yes -s"
alias fp="fuzzypkg"
alias liwa="xwinwrap -ov -g 1366x768+0+0 -- mpv -wid WID --no-osc --loop-file --player-operation-mode=cplayer --panscan=1.0 --no-audio"

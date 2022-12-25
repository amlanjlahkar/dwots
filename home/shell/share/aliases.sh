#!/usr/bin/env bash
# general
alias ls="ls --color=never --group-directories-first --sort=version -FGh"
alias ll="ls --color=never --group-directories-first --sort=version --time-style='+%y-%m-%d %I:%M%p' -lFGh"
alias la="ls --color=never --group-directories-first --sort=version --time-style='+%y-%m-%d %I:%M%p' -AlFGh"
alias clr="clear && cd"
alias rm="rm -iv"
alias cp="cp --preserve=all -Riv"
alias mv="mv -iv"
alias tree="tree -n"
alias rg="rg --colors 'path:fg:green' --colors 'match:fg:yellow' --colors 'line:fg:245'"
alias grep="grep --color=auto"
alias open="xdg-open"
alias shrm="shred --size=2048K -uv"

# package manager
if [ "$(grep "^ID" /etc/os-release | cut -d'=' -f2)" = 'arch' ]
then
    alias owns="pacman --color=never -Qo"
    alias up="doas pacman -Syu"
    alias ua="yay -Syua --cleanafter"
fi

# xbps
if [ "$(grep "^ID" /etc/os-release | cut -d'=' -f2)" = '"void"' ]
then
    alias up="doas xbps-install -Su"
    alias xrm="doas xbps-remove -Rov"
    alias xin="doas xbps-install -S"
fi

# other
alias termcolors="curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash"
alias main="doas makewhatis -a"
alias fcheck="fc-list : family style spacing | grep -i"
alias vg="valgrind --leak-check=yes -s"
alias liwa="xwinwrap -ov -g 1366x768+0+0 -- mpv -wid WID --no-osc --no-osd-bar --loop-file --player-operation-mode=cplayer --panscan=1.0 --no-audio --no-input-default-bindings"

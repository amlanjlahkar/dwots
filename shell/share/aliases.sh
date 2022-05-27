# general
alias ls="ls --color=never"
alias la="ls --color=never --group-directories-first --sort=version --time-style='+%y-%m-%d %I:%M%p' -AlFGh"
alias clr="clear && cd"
alias rm="rm -iv"
alias cp="cp --preserve=all -Riv"
alias mv="mv -iv"
alias rg="rg --colors 'path:fg:green' --colors 'match:fg:yellow' --colors 'line:fg:245'"
alias grep="grep --color=auto"
alias open="xdg-open"

# git
alias gst="git status"
alias gdf="git diff"
alias glg="git log"
alias gck="git checkout"

# pacman and yay
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
    alias checkfor="xbps-query --repository --search"
fi

# other
alias termcolors="curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash"
alias main="doas makewhatis -a"

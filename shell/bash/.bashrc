export HISTFILE="${XDG_CACHE_HOME}/bash/history"

## Prompt
source /usr/share/git/git-prompt.sh
GIT_PS1_DESCRIBE_STYLE='contains'
GIT_PS1_SHOWCOLORHINTS='y'
GIT_PS1_SHOWDIRTYSTATE='y'
GIT_PS1_SHOWSTASHSTATE='y'
GIT_PS1_SHOWUNTRACKEDFILES='y'
GIT_PS1_SHOWUPSTREAM='auto'

PS1='\u\e[01;32m@\e[m\H in \e[00;34m\w\e[m$(__git_ps1 " [%s]") \$ '

## Aliases
source "${XDG_CONFIG_HOME}/bash/bash_aliases"

## Functions
function mkcd () {
    mkdir -p "$1" && cd "$1"
}

# go up n directories
function gd () {
    declare godir; declare limit="$1"
    [ "$limit" = 'top' ] && cd "${HOME}/$(pwd | cut -d'/' -f4)"
    [[ -z "$limit" || "$limit" -le 0 ]] && limit=1

    for (( i=1; i < limit; i++ )); do
        godir="../$godir"
    done

    if ! cd "$godir"; then
        printf "%s\n" "Couldn't go up \"$limit\" directories."
    fi
}

# copy history to clipboard
function hist() {
    fc -lnr 1 | sort | uniq | fzf | tr '\n' ' ' | xclip -i -selection clipboard
}

# cd on quit for nnn
function n() {
    # block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# serch for package info using fzf
function pkgi() {
    os="$(grep "^ID" /etc/os-release | cut -d'=' -f2)"

    case "$os" in
        'arch')
	    pacman -Qn | awk '{print $1}' | fzf --header='installed packages(native)' --preview='pacman -Qi {1}' ;;
	'"void"')
	    xbps-query -l | awk '{print $2}' | fzf --header='installed packages' --preview='xbps-query -S {1}' ;;
    esac
}

## Extensions
source "/usr/share/fzf/key-bindings.bash"
eval "$(lua ${HOME}/.local/bin/z.lua --init bash enhanced once)"


export HISTFILE="${HOME}/.local/share/bash/history"

## Prompt
source /usr/share/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM='auto'

export PROMPT_COMMAND=prompt_string
prompt_string() {
    local CReset='\[\e[0m\]'
    local CRed='\[\e[00;31m\]'
    local CGreen='\[\e[01;32m\]'
    local CYellow='\[\e[00;33m\]'
    local CBlue='\[\e[00;34m\]'

    PS1="\u in ${CBlue}\W${CReset}$(__git_ps1 " (%s)") \$ "
}


## Options
set -C
set -o vi
shopt -s cdspell
shopt -s autocd
shopt -s direxpand

shopt -s globstar
shopt -s extglob

# list possible matches immediately when pressing <TAB>
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

bind -x '"\C-l": clear;'

## Aliases
source "${HOME}/dwots/shell/share/aliases.sh"

## Functions
mkcd () {
    mkdir -p "$1" && cd "$1"
}

# go up n directories
gd () {
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
hist() {
    fc -lnr 1 | sort | uniq | fzf | tr '\n' ' ' | xclip -i -selection clipboard
}

# cd on quit for nnn
n() {
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
pkgi() {
    os="$(grep "^ID" /etc/os-release | cut -d'=' -f2)"

    case "$os" in
        'arch')
	    pacman -Qn | awk '{print $1}' | fzf --header='installed packages(native)' --preview='pacman -Qi {1}' ;;
	'"void"')
	    xbps-query -l | awk '{print $2}' | fzf --header='installed packages' --preview='xbps-query -S {1}' ;;
    esac
}

# short alias for finding files
look() { find $HOME -type f -iname "$@"; }

## Extensions
source "/usr/share/fzf/key-bindings.bash"
eval "$(lua ${HOME}/.local/bin/z.lua --init bash enhanced once)"


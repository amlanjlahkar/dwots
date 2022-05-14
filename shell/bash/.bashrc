# Helper function
is_avail() {
  IFS=': ' read str <<< "$(whereis $1)"
  [ -n "$str" ] && true || false
}

## History management
export HISTFILE="${HOME}/.local/share/bash/history"
export HISTFILESIZE="-1"
export HISTSIZE="-1"
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="[%F %T] "

## Prompt
if is_avail git; then
  source /usr/share/git/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=''
export GIT_PS1_SHOWUPSTREAM='auto'
export PROMPT_DIRTRIM=3
export PROMPT_COMMAND="history -a; prompt_main; printf '\n'"

_CReset='\e[0m'
_CRed='\e[00;31m'
_CGreen='\e[01;32m'
_CYellow='\e[00;33m'
_CBlue='\e[00;34m'
prompt_char() {
  if [ $? -eq 0 ]; then
    echo "\e[01;32m>>\e[0m "
  else
    echo "\e[00;31m>>\e[0m "
  fi
}
prompt_main() {
  PS1='\e[00;34m  \w\e[0m$(__git_ps1 " (%s)")\n\$ '
}

## Options
set -C
set -o vi
shopt -s cdspell
shopt -s autocd
shopt -s direxpand
shopt -s globstar
shopt -s extglob

## Keybinds
# unset default keybinds for these signals
stty stop undef
stty werase undef

# list possible matches immediately when pressing <TAB>
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

bind "\C-l":clear-display
bind "\C-b":shell-backward-kill-word

bind -x '"\C-a":"tmux attach"'
bind -x '"\C-f":"fdwots"'

## Aliases
source "${HOME}/dwots/shell/share/aliases.sh"

## Functions
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# go up n directories
gd() {
  declare godir
  declare limit="$1"
  [ "$limit" = 'top' ] && cd "${HOME}/$(pwd | cut -d'/' -f4)"
  [[ -z "$limit" || "$limit" -le 0 ]] && limit=1

  for ((i = 1; i < limit; i++)); do
    godir="../$godir"
  done

  if ! cd "$godir"; then
    printf "%s\n" "Couldn't go up \"$limit\" directories."
  fi
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
    rm -f "$NNN_TMPFILE" >/dev/null
  fi
}

# serch for package info using fzf
pkgi() {
  os="$(grep "^ID" /etc/os-release | cut -d'=' -f2)"

  case "$os" in
    'arch')
      pacman -Qn | awk '{print $1}' | fzf --header='installed packages(native)' --preview='pacman -Qi {1}'
      ;;
    '"void"')
      xbps-query -l | awk '{print $2}' | fzf --header='installed packages' --preview='xbps-query -S {1}'
      ;;
  esac
}

## Extensions
if is_avail fzf; then
  source "/usr/share/fzf/key-bindings.bash"
fi
if is_avail z.lua; then
  eval "$(lua ${HOME}/.local/bin/z.lua --init bash enhanced once)"
fi

export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

alias luamake=/home/amlan/tools/lua_lsp/3rd/luamake/luamake

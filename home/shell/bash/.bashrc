#!/usr/bin/env bash

# Helper function
__is_avail() { [ -z "$(command -v "$1")" ] && return 1 || return 0; }
__xiex() {
  if ! fd --quiet --max-depth 1 --type f "$1" $PWD; then
    printf >&2 '%s\n' "Not inside a project directory!"
    return 1
  else
    printf '%s\n' "Running '$2' ..."
    eval "$2"
  fi
}

## History management
export HISTFILE="${HOME}/.local/share/bash/history"
export HISTFILESIZE=
export HISTSIZE=
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="[%F %T] "

## Prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=''
export GIT_PS1_SHOWUPSTREAM='auto'
export PROMPT_DIRTRIM=3
export PROMPT_COMMAND="prompt_main; printf '\n'; history -a; history -c; history -r"

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
  if __is_avail git; then
    source /usr/share/git/git-prompt.sh
    PS1='in\e[00;34m \w\e[0m$(__git_ps1 " (%s)")\n\$ '
  else
    PS1='in\e[00;34m \w\e[0m\n\$ '
  fi
}

## Options
set -C
set -o vi
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
shopt -s direxpand
shopt -s globstar
shopt -s extglob
shopt -s histappend

## Keybinds
# unset default keybinds for these signals
stty stop undef
stty werase undef

# list possible matches immediately when pressing <TAB>
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'

bind "\C-l":clear-display
bind "\C-h":shell-backward-kill-word

bind -x '"\C-f":"fdwots"'
bind -x '"\C-s":"source $HOME/.bashrc"'

## Aliases
source "${HOME}/dwots/home/shell/share/aliases.sh"

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

  for ((i = 1; i <= limit; i++)); do
    godir="../$godir"
  done

  if ! cd "$godir"; then
    printf >&2 '%s\n' "Couldn't go up \"$limit\" directories."
  fi
}

# cd on quit for nnn
n() {
  # block nesting of nnn in subshells
  if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    printf >&2 '%s\n' "nnn is already running"
    return
  fi

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" >/dev/null
  fi
}

# open neovim with fuzzy finder
nv() {
  if ! fd --quiet --type d telescope.nvim \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/; then
    printf >&2 '%s\n' "Telescope is missing!"
    return 1
  fi
  if [[ -n "$1" && -d "$1" ]]; then
    nvim "$1" \
      "+lua require('telescope.builtin').find_files({ cwd = '$(realpath "$1")' })"
  elif [[ -n "$1" && -e "$1" ]]; then
    nvim "$1"
  else
    nvim ./ "+Telescope find_files"
  fi
}

# search for package info using fzf
pkgi() {
  os="$(grep "^ID" /etc/os-release | cut -d'=' -f2)"

  case "$os" in
    'arch')
      pacman -Qn | awk '{print $1}' | fzf --header='installed packages(native)' --preview='pacman -Qi {1}' \
        | xargs -r -I {} pacman -Qi {}
      ;;
    '"void"')
      xbps-query -l | awk '{print $2}' | fzf --header='installed packages' --preview='xbps-query -S {1}' \
        | xargs -r -I {} xbps-query -S {}
      ;;
  esac
}

# project specific mappings
tailx() {
  cmd="npx tailwindcss -i ./style/tailwind/input.css -o ./dist/output.css --watch"
  __xiex tailwind.config.js "$cmd"
}

## Extensions
if __is_avail fzf; then
  source "/usr/share/fzf/key-bindings.bash"
fi

if __is_avail zoxide; then
  eval "$(zoxide init bash)"
fi

# lazyload node version manager
# taken from https://gist.github.com/fl0w/07ce79bd44788f647deab307c94d6922
# lazynvm() {
#   unset -f nvm node npm npx
#   export NVM_DIR="${HOME}/.config/nvm"
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
#   if [ -f "$NVM_DIR/bash_completion" ]; then
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
#   fi
# }
#
# nvm() {
#   lazynvm
#   nvm $@
# }
#
# node() {
#   lazynvm
#   node $@
# }
#
# npm() {
#   lazynvm
#   npm $@
# }
#
# npx() {
#   lazynvm
#   npx $@
# }

export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

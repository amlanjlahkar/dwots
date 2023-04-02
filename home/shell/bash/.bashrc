#!/usr/bin/env bash
#shellcheck disable=SC1090,1091

export SHELL="/usr/local/bin/bash"

export HISTFILE="${HOME}/.local/share/bash/history"
export HISTFILESIZE=
export HISTSIZE=
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="[%F %T] "

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=''
export GIT_PS1_SHOWUPSTREAM='auto'
export PROMPT_DIRTRIM=2
export PROMPT_COMMAND="prompt_main; printf '\n'; history -a; history -c; history -r"

_CReset='\e[0m'
_CRed='\e[00;31m'
_CGreen='\e[01;32m'
_CYellow='\e[00;33m'
_CBlue='\e[00;34m'

print_exit_code() {
  EXIT=$?
  [ $EXIT -ne 0 ] && printf '[\e[00;31m%s\e[0m]' "$EXIT"
}

prompt_main() {
  if __is_avail git; then
    source /usr/share/git/git-prompt.sh
    # shellcheck disable=SC2025
    PS1='in \e[00;35m\w\e[0m$(__git_ps1 " (%s)") $(print_exit_code)\n '
  else
    #shellcheck disable=SC2025
    PS1='in \e[00;35m\w $(print_exit_code)\n '
  fi
}

set -C
set -o vi
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s extglob
shopt -s histappend
shopt -s histverify
shopt -s checkwinsize

# unset default keybinds for these signals
stty stop undef
stty werase undef

bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'

bind "\C-l":clear-display

bind -x '"\C-o":"oldvi"'
# shellcheck disable=SC2016
bind '"\C-f":"source $HOME/.local/bin/user_scripts/fdwots"' # conditionally alters pwd
# shellcheck disable=SC2016
bind -x '"\C-s":"source $HOME/.bashrc"'

# functions
__is_avail() { [ -z "$(command -v "$1")" ] && return 1 || return 0; }
__xiex() {
  if ! fd -H --quiet --max-depth 1 --type f "$1" "$PWD"; then
    printf >&2 '%s\n' "Not inside a project directory!"
    return 1
  else
    printf '%s\n' "Running '$2' ..."
    eval "$2"
  fi
}
__is_cached() {
  IFS=$'\n' readarray hist < <(grep -v '^#.*' "$HISTFILE" | tail -n10)
  printf '%s\0' "${hist[@]}" | grep -Ewq -- "^$1" && return 0 || return 1
}

# package manager
# shellcheck disable=SC2015
xo() { xbps-query -o "$(realpath "$1")"; }
up() { __is_cached 'up' && doas xbps-install -u || doas xbps-install -Su; }
# shellcheck disable=SC2015
xin() { __is_cached 'xin' && doas xbps-install "$1" || doas xbps-install -S "$1"; }
xrm() {
  read -r pkg < <(xpkg -m | grep -iF -- "$1")
  if [ -n "$pkg" ]; then
    doas xbps-remove -Rov "$pkg"
  else
    printf '%s\n%s\n' "Couldn't uninstall package '$pkg'." \
      "(either the package isn't installed or uninstalling it breaks dependency)"
  fi
}

mkcd() { mkdir -p "$1" && cd "$1" || return; }

# extract/compress
yank() {
  [ ! -d "$2" ] && mkdir -p "$2"
  if [ "${1#*\.}" = 'zip' ]; then
    unzip "$1" -d "$2"
  else
    tar --verbose -xzf "$1" -C "$2"
  fi
}
cmpr() {
  if [ "${1#*\.}" = 'zip' ]; then
    zip "$1" "${@:2}"
  else
    tar --verbose -czf "$1" "${@:2}"
  fi
}

# go up n directories
gd() {
  declare godir
  declare limit="$1"
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
  nnn -H "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" >/dev/null
  fi
}

# open neovim with fuzzy finder
nv() {
  # if ! fd --quiet --type d telescope.nvim \
  #   "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/; then
  #   printf >&2 '%s\n' "Telescope is missing!"
  #   return 1
  # fi
  # if [[ -n "$1" && -d "$1" ]]; then
  #   nvim "$1" \
  #     "+lua require('telescope.builtin').find_files({ cwd = '$(realpath "$1")' })"
  # elif [[ -n "$1" && -e "$1" ]]; then
  #   nvim "$1"
  # else
  #   nvim ./ "+Telescope find_files"
  # fi
  if [[ -n "$1" && -d "$1" ]]; then
    nvim "+lua require('oil').open('$1')"
  elif [ -z "$1" ]; then
    nvim "+lua require('oil').open()"
  else
    printf '%s\n' "Not a directory"
  fi
}

# search for package info using fzf
pkgi() {
  IFS='=' read -r _ o < <(grep "^ID" /etc/os-release)
  os="${o//\"/}"

  case "$os" in
    'arch')
      pacman -Qn | awk '{print $1}' | fzf --header='installed packages(native)' --preview='pacman -Qi {1}' \
        | xargs -r -I {} pacman -Qi {}
      ;;
    'void')
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

jsrc() {
  fpath="src/main/java/com/amlanjlahkar"
  [ ! -d "${fpath}" ] && mkdir -p "$fpath"
  __xiex settings.gradle "touch $fpath/${1}.java"
}

cratch() {
  __xiex c.scr "read -r -p 'filename: ' fname"
  [ -z "$fname" ] && nvim scratch_"${RANDOM::3}".c || nvim "$fname".c
}

# extensions
__is_avail fzf && source "/usr/share/fzf/key-bindings.bash"
__is_avail zoxide && eval "$(zoxide init bash)"
__is_avail direnv && eval "$(direnv hook bash)"

if __is_avail vivid; then
  LS_COLORS="$(vivid generate boo)"
  export LS_COLORS
fi

export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" "--no-use"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source "${HOME}/dwots/home/shell/share/aliases.sh"

#!/usr/bin/env bash
#shellcheck disable=SC1090,2015

# utils
mkcd() { mkdir -p "$1" && cd "$1" || return; }

lc() {
  declare -i depth
  [ -z "$1" ] && return
  [ -z "$2" ] && depth=0 || depth="$2"
  find "${1}"/* -mindepth "$depth" -maxdepth "$depth" | wc -l
}

yank() {
  [[ -n "$2" && ! -d "$2" ]] && mkdir -p "$2"
  if [ "${1#*\.}" = 'zip' ]; then
    unzip "$1" -d "$2"
  else
    tar_cmd="tar -xavf -- $1"
    [ -z "$2" ] && eval "$tar_cmd" || eval "$tar_cmd -C $2"
  fi
}

cmpr() {
  if [ "${1#*\.}" = 'zip' ]; then
    zip "$1" "${@:2}"
  else
    tar --zstd -cvf -- "$1" "${@:2}"
  fi
}


# nnn alias
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

# nvim alias
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
  #
  if [[ -n "$1" && -d "$1" ]]; then
    nvim "$1"
  elif [ -z "$1" ]; then
    nvim ./
  else
    printf '%s\n' "Not a directory"
  fi
}

# package manager related
__is_cached() {
  IFS=$'\n' readarray hist < <(grep -v '^#.*' "$HISTFILE" | tail -n10)
  printf '%s\0' "${hist[@]}" | grep -Ewq -- "^$1" && return 0 || return 1
}

# shellcheck disable=SC2015
xo() { xbps-query -o "$(realpath "$1")"; }

up() { __is_cached 'up' && doas xbps-install -u || doas xbps-install -Su; }

# shellcheck disable=SC2015
xin() { __is_cached 'xin' && doas xbps-install "$@" || doas xbps-install -S "$@"; }

xrm() {
  read -r pkg < <(xpkg -m | grep -iF -- "$1")
  if [ -n "$pkg" ]; then
    doas xbps-remove -Rov "$pkg"
  else
    printf '%s\n%s\n' "Couldn't uninstall package '$1'." \
      "(either the package isn't installed or uninstalling it breaks dependency)"
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
__xiex() {
  if ! fd -H --quiet --max-depth 1 --type f "$1" "$PWD"; then
    printf >&2 '%s\n' "Not inside a project directory!"
    return 1
  else
    printf '%s\n' "Running '$2' ..."
    eval "$2"
  fi
}

tailx() {
  cmd="npx tailwindcss -i ./style/tailwind/input.css -o ./dist/output.css --watch"
  __xiex tailwind.config.js "$cmd"
}

jsrc() {
  fpath="src/main/java/com/amlanjlahkar"
  [ ! -d "${fpath}" ] && mkdir -p "$fpath"
  __xiex settings.gradle "touch $fpath/${1}.java"
}

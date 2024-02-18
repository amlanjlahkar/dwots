#!/usr/bin/env bash
#shellcheck disable=SC1090,2015

# utils
mkcd() { mkdir -p "$1" && cd "$1" || return; }

tmp() {
  dir="$(mktemp -d)"
  pushd "$dir" || return 1
}

lc() {
  declare -i depth
  [ -z "$1" ] && return
  [ -z "$2" ] && depth=0 || depth="$2"
  find "${1}"/* -mindepth "$depth" -maxdepth "$depth" | wc -l
}

yank() {
  if [ -z "$2" ]; then
    printf >&2 "Must specify a target directory"
    return
  fi
  [ ! -d "$2" ] && mkdir -p "$2"
  if [ "${1##*\.}" = 'zip' ]; then
    unzip "$1" -d "$2"
  else
    tar_cmd="tar -xavf $1"
    [ -z "$2" ] && eval "$tar_cmd" || eval "$tar_cmd -C $2"
  fi
}

cmpr() {
  if [ "${1##*\.}" = 'zip' ]; then
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
  if [[ -n "$1" && -d "$1" ]]; then
    nvim "$1"
  elif [ -z "$1" ]; then
    if fd -q -d1 -I Session.vim; then
      nvim -S Session.vim
    else
      nvim ./
    fi
  else
    printf "Not a directory"
  fi
}

# package manager related

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

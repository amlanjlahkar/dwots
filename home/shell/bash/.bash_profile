#!/usr/bin/env bash

case "$-" in
  *i*)
    [ -r ~/.bashrc ] && source ~/.bashrc
    ;;
esac

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"

export EDITOR=nvim
export TERMINAL=alacritty
export BROWSER=firefox

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:${HOME}/.local/bin/scripts:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"
export CDPATH=".:..:~:~/.config"

export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'

export FZF_DEFAULT_COMMAND="fd --one-file-system"
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='> '
--no-scrollbar --no-separator --no-border --no-height --margin=1 --preview-window='border-sharp'
--color bg+:0,fg:8,preview-fg:15,hl:3,border:8,gutter:0
--color info:7,prompt:15,query:15:regular,spinner:7,pointer:9,marker:9,header:4"

export PATH="${HOME}/.cache/fnm_multishells/26141_1700332542578/bin":$PATH
export FNM_DIR="${HOME}/.local/share/fnm"
export FNM_COREPACK_ENABLED="false"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_RESOLVE_ENGINES="false"
export FNM_ARCH="arm64"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_MULTISHELL_PATH="${HOME}/.cache/fnm_multishells/26141_1700332542578"
export FNM_LOGLEVEL="info"

export NNN_TRASH=1

export TERMINFO_DIRS="$TERMINFO_DIRS":"$XDG_DATA_HOME"/terminfo

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

export LANG=en_US.UTF-8


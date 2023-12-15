#!/usr/bin/env bash

case "$-" in
  *i*)
    [ -r ~/.bashrc ] && source ~/.bashrc
    ;;
esac

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"

export EDITOR=nvim
export TERMINAL=alacritty
export BROWSER=firefox

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/coreutils/libexec/gnubin:/usr/local/bin:${HOME}/.local/bin/user_scripts:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"
export CDPATH=".:..:~:~/.config"

export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'

export FZF_DEFAULT_COMMAND="fd --one-file-system"
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='> '
--no-scrollbar --no-separator --no-border --no-height --margin=1 --preview-window='border-sharp'
--color bg+:0,fg:8,preview-fg:15,hl:3,border:8,gutter:0
--color info:7,prompt:15,query:15:regular,spinner:7,pointer:9,marker:9,header:4"

export FNM_DIR="${HOME}/.local/share/fnm"
eval "$(fnm env --use-on-cd)"

export NNN_TRASH=1

export TERMINFO_DIRS="$TERMINFO_DIRS":"$XDG_DATA_HOME"/terminfo

export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

export LANG=en_US.UTF-8


export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

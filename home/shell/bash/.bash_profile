#!/usr/bin/env bash

case "$-" in
  *i*)
    [ -r ~/.bashrc ] && source "$HOME/.bashrc"
    ;;
esac

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export OPT_HOME="${HOME}/.local/opt"

export EDITOR=nvim
export TERMINAL=ghostty
export BROWSER=firefox

export LANG=en_US.UTF-8
export PATH="/usr/local/bin:${HOME}/.local/scripts:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"
export CDPATH=".:..:~:~/.config"

export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# Homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# CLI utils
export FZF_DEFAULT_COMMAND="fd --one-file-system"
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='> '
--no-color --no-scrollbar --no-separator --no-border --no-height --margin=1 --preview-window='border-sharp'
--bind=ctrl-n:down,ctrl-p:up"

export NNN_TRASH=1
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG="p:preview-tui;o:fzcd;z:zoxide_cd"
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

export GNUPGHOME="$XDG_DATA_HOME/gnupg"

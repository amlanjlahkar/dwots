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
export TERMINAL=alacritty
export BROWSER=firefox

export LANG=en_US.UTF-8
export PATH="/usr/local/bin:${HOME}/.local/bin/user_scripts:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin"
export CDPATH=".:..:~:~/.config"

export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/opt/make/libexec/gnubin:$PATH"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# opt
export FZF_DEFAULT_COMMAND="fd --one-file-system"
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='> '
--no-scrollbar --no-separator --no-border --no-height --margin=1 --preview-window='border-sharp'
--color bg+:0,fg:8,preview-fg:15,hl:3,border:8,gutter:0
--color info:7,prompt:15,query:15:regular,spinner:7,pointer:9,marker:9,header:4"

export NNN_TRASH=1

export TERMINFO_DIRS="$TERMINFO_DIRS":"$XDG_DATA_HOME"/terminfo

export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# lang/tools
export FNM_DIR="$XDG_DATA_HOME/fnm"
eval "$(fnm env --use-on-cd)"

export CARGO_HOME="$OPT_HOME/rust/cargo"
export RUSTUP_HOME="$OPT_HOME/rust/rustup"
source "$CARGO_HOME/env"

export PATH="$PATH:$XDG_DATA_HOME/bob/nvim-bin"

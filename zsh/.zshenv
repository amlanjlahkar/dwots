#!/bin/sh

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export PATH="${HOME}/.local/bin:${HOME}/.local/bin/scripts:${HOME}/.local/bin/notification-modules:${PATH}"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# general
export OPENER="xdg-open"
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERMINAL=st
export BROWSER=qutebrowser
export READER=zathura
export MANPAGER=less

# clipboard manager
export CM_DIR=/tmp
export CM_MAX_CLIPS=30
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=10

# nnn file manager
export NNN_TRASH=1
export NNN_PLUG="c:fzcd;o:fzopen;p:preview-tui"
export NNN_BMS="d:${HOME}/documents/pdfs"
export NNN_FIFO="/tmp/nnn.fifo"
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# other
export QT_QPA_PLATFORMTHEME=qt5ct

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='🔍 ' --height 90% --layout reverse-list --border sharp
--color fg:#999999,bg:#212121,preview-fg:#abb2bf,hl:#c0c0c0,fg+:#abb2bf,bg+:#323232,gutter:#212121,hl+:#c0c0c0,border:#323232
--color info:#abb2bf,prompt:#abb2bf,spinner:#abb2bf,pointer:#abb2bf,marker:#abb2bf,header:#abb2bf"
#--color fg:#5c6370,bg:#282c34,preview-fg:#abb2bf,hl:#98c379,fg+:#abb2bf,bg+:#3e4452,gutter:#282c34,hl+:#e5c07b,border:#3e4452
#--color info:#5c6370,prompt:#5c6370,spinner:#5c6370,pointer:#61afef,marker:#e06c75,header:#5c6370"

export _ZL_DATA="${HOME}/.local/share/zlua"

# following the XDG Base Directory specs
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XAUTHORITY="/run/user/1000/Xauthority"
export VSCODE_PORTABLE="${XDG_DATA_HOME}/vscode"
export ANDROID_HOME="${XDG_DATA_HOME}/android"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

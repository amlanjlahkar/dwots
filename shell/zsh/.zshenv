#!/bin/sh

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export PATH="${HOME}/.local/bin:${HOME}/.local/bin/user_scripts:${HOME}/.local/bin/sb_scripts:${PATH}"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# general
export OPENER="xdg-open"
export EDITOR=nvim
export VISUAL="$EDITOR"
export TERMINAL=alacritty
export BROWSER=librewolf
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

export FZF_DEFAULT_COMMAND='fd'
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='🔍 ' --height 45% --layout reverse-list --border none
--color fg:7,bg:0,preview-fg:15,hl:3,fg+:15:regular,bg+:8,gutter:0,hl+:3:regular,border:8
--color info:15,prompt:15,query:15:regular,spinner:15,pointer:9,marker:9,header:4"

export _ZL_DATA="${HOME}/.local/share/zlua"
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

# following the XDG Base Directory specs
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XAUTHORITY="/run/user/1000/Xauthority"
export VSCODE_PORTABLE="${XDG_DATA_HOME}/vscode"
export ANDROID_HOME="${XDG_DATA_HOME}/android"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

export NO_AT_BRIDGE=1

#!/bin/sh

export ZDOTDIR="${HOME}/.config/zsh"
export PATH="${HOME}/.local/bin:${HOME}/.local/bin/scripts:${HOME}/.local/bin/notification-modules:${PATH}"

# general
export OPENER="xdg-open"
export EDITOR=nvim
export VISUAL="${EDITOR}"
export TERMINAL=st
export BROWSER=qutebrowser
export READER=zathura
export MANPAGER=most

# other
export QT_QPA_PLATFORMTHEME=qt5ct

export MOST_EDITOR="vim %s -g %d"

export MOST_INITFILE="${HOME}/.config/most/mostrc"

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='🔍 ' --height 60% --layout reverse-list --border sharp 
--color fg:#839496,bg:#002b36,hl:#2aa198,fg+:#839496,bg+:#073642,gutter:#002b36,hl+:#b58900,border:#073642 
--color info:#93a1a1,prompt:#93a1a1,spinner:#93a1a1,pointer:#2aa198,marker:#cb4b16,header:#93a1a1"

# clipboard manager
export CM_DIR=/tmp
export CM_MAX_CLIPS=30
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=10

# nnn file manager
export NNN_TRASH=1
export NNN_PLUG="c:fzcd;o:fzopen;p:preview-tui"
export NNN_BMS="a:${HOME}/mtpfs/rmx2001"
export NNN_FIFO="/tmp/nnn.fifo"

# following the XDG Base Directory specs
export XINITRC="${HOME}/.config/X11/xinitrc"
export XAUTHORITY="/run/user/1000/Xauthority"
export VSCODE_PORTABLE="${HOME}/.local/share/vscode"
export ANDROID_HOME="${HOME}/.config/android"
export CARGO_HOME="${HOME}/.local/share/cargo"
export LESSHISTFILE="${HOME}/.cache/less/history"

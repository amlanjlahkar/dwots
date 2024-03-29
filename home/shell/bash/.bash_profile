# This is the default file for exporting env variables
# for the shells that I use(bash and zsh)
# if using bash then, link this to .bash_profile
# or if using zsh, then link it to .zshenv

case "$-" in
  *i*)
    [ -r ~/.bashrc ] && source ~/.bashrc
    ;;
esac

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"

export PATH="${HOME}/.local/bin:${HOME}/.local/bin/user_scripts:${HOME}/.local/bin/sb_scripts:${XDG_DATA_HOME}/bob/nvim-bin:${PATH}"
export CDPATH=".:..:~:~/.local:~/.config"
export TIME_STYLE="+%y-%m-%d %I:%M%p"
export LESS_TERMCAP_so=$'\E[30;43m'
export LESS_TERMCAP_se=$'\E[39;49m'
export NO_AT_BRIDGE=1

# defaults
export OPENER="xdg-open"
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=alacritty
export BROWSER=firefox
export READER=zathura
export MANPAGER=less

export CM_DIR=/tmp
export CM_MAX_CLIPS=30
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=10

export NNN_TRASH=1
export NNN_PLUG="o:fzcd;p:preview-tui"
export NNN_BMS="d:${HOME}/documents/pdfs;b:${HOME}/bca-related/notes;n:${HOME}/documents/notes"
export NNN_FIFO="/tmp/nnn.fifo"
BLK="06" CHR="0D" DIR="05" EXE="01" REG="00" HARDLINK="00" SYMLINK="0D" MISSING="00" ORPHAN="09" FIFO="04" SOCK="0B" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

export QT_QPA_PLATFORMTHEME=qt5ct
export FZF_DEFAULT_COMMAND="fd --one-file-system"
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='  '
--no-scrollbar --no-separator --no-border --no-height --margin=1 --preview-window='border-sharp'
--color bg+:0,fg:8,preview-fg:15,hl:3,border:8,gutter:0
--color info:7,prompt:15,query:15:regular,spinner:7,pointer:9,marker:9,header:4"

# use xdg base directory compatible specs
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export MYSQL_HISTFILE="${XDG_DATA_HOME}/mysql_history"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export MYVIMRC="${XDG_CONFIG_HOME}/nvim/init.lua"

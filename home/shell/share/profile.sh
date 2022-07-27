# This is the default file for exporting env variables
# for the shells that I use(bash and zsh)
# if using bash then, link this to .bash_profile
# or if using zsh, then link it to .zshenv

if [[ "$SHELL" =~ bash ]]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"

export PATH="${HOME}/.local/bin:${HOME}/.local/bin/user_scripts:${HOME}/.local/bin/sb_scripts:${HOME}/tools/language_specific/Lua/lua_lsp/bin:${PATH}"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export TIME_STYLE="+%y-%m-%d %I:%M%p"

# general
export OPENER="xdg-open"
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=alacritty
export BROWSER=firefox
export READER=zathura
export MANPAGER=less

# clipboard manager
export CM_DIR=/tmp
export CM_MAX_CLIPS=30
export CM_LAUNCHER=rofi
export CM_HISTLENGTH=10

# nnn file manager
export NNN_TRASH=1
export NNN_PLUG="o:fzcd;p:preview-tui"
export NNN_BMS="d:${HOME}/documents/pdfs;b:${HOME}/bca-related/notes;n:${HOME}/documents/notes"
export NNN_FIFO="/tmp/nnn.fifo"
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# other
export QT_QPA_PLATFORMTHEME=qt5ct
export FZF_DEFAULT_COMMAND="fd --one-file-system"
export FZF_DEFAULT_OPTS="--cycle --history=${HOME}/.local/share/fzfhist --prompt='🔍 ' --height 45% --layout reverse-list --border none
--color fg:8,bg:'#191724',preview-fg:15,hl:3,fg+:15:regular,bg+:'#191724',gutter:'#191724',hl+:3:regular,border:8
--color info:7,prompt:15,query:15:regular,spinner:7,pointer:9,marker:9,header:4"

export _ZL_DATA="${HOME}/.local/share/zlua"
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

# following the XDG Base Directory specs
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
export VSCODE_PORTABLE="${XDG_DATA_HOME}/vscode"
export ANDROID_HOME="${XDG_DATA_HOME}/android"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}"/gtk-2.0/gtkrc
export GNUPGHOME="${XDG_DATA_HOME}"/gnupg
export MYSQL_HISTFILE="${XDG_DATA_HOME}"/mysql_history
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/nvm/.npmrc
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

export NO_AT_BRIDGE=1

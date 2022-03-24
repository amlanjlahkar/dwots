# configuration file for z shell

# General
# setting up history management for zsh sessions
export HISTFILE="${HOME}/.cache/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_find_no_dups

# setting up tab completion
autoload -Uz compinit && compinit -u
_comp_options+=(globdots)
zmodload zsh/complist
zstyle ':completion:*' menu select

# completion options
setopt always_to_end
setopt auto_menu
setopt auto_list

# other useful options
setopt sh_word_split
setopt glob_subst
zle_highlight=('paste:none')
setopt auto_cd
setopt interactive_comments

# append custom function dir to fpath
fpath=( ~/.config/zsh/zsh_functions "${fpath[@]}" )
autoload -Uz gd mkcd n pkgi hist

# Keybinds
export KEYTIMEOUT=1
bindkey -v
bindkey -s '^P' 'tpr\n'
bindkey -s '^\' '~/handle_mysql.sh\n'
bindkey -s '^H' 'hist\n'

# Plugins
source "${ZDOTDIR}/zsh_functions/add_plug"
# zsh_plug "zsh-users/zsh-autosuggestions"
# zsh_plug "z-shell/fast-syntax-highlighting"

# Extra
source "${HOME}/dwots/shell/share/aliases.sh"
source "${ZDOTDIR}/zsh_prompt"
source "/usr/share/fzf/key-bindings.zsh"
eval "$(lua ${HOME}/.local/bin/z.lua --init zsh)"

# load excutable for node version manager(nvm) on startup
# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


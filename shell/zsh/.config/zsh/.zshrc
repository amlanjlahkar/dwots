# configuration file for z shell

#---General---#
# setting up history management for zsh sessions
export HISTFILE="${HOME}/.cache/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory
setopt inc_append_history
setopt share_history
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

#---Adding personal functions' dir to fpath---#
fpath=( ~/.config/zsh/zsh_functions "${fpath[@]}" )
# calling functions
autoload -Uz gd mkcd n pkgi

#---Plugins---#
source "${ZDOTDIR}/zsh_functions/add_plug"  # simple function used for sourcing plugin files
# calling plugins
#zsh_plug "zsh-users/zsh-syntax-highlighting"
zsh_plug "zsh-users/zsh-autosuggestions"

#---Plugins-tweaks---#
#source "${ZDOTDIR}/plugin-tweaks/tweak_zsh-syntax-highlighting.zsh"

#---Keybinds---#
bindkey -v
export KEYTIMEOUT=1

# tpr is one of my personal scripts.
bindkey -s '^P' 'tpr\n'

#---Other---#
source "${ZDOTDIR}/zsh_aliases"
source "${ZDOTDIR}/zsh_prompt"
source "/usr/share/fzf/key-bindings.zsh"
eval "$(lua ${HOME}/.local/bin/z.lua --init zsh)"

# load excutable for node version manager(nvm) on startup
# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


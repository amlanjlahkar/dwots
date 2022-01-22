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
fpath=( ~/.config/zsh/zshfunctions "${fpath[@]}" )
# calling functions
autoload -Uz gd mkcd n

#---Plugins---#
source "${ZDOTDIR}/zshfunctions/add_plug"  # simple function used for sourcing plugin files
# calling plugins
#zsh_plug "zsh-users/zsh-syntax-highlighting"
zsh_plug "zsh-users/zsh-autosuggestions"

#---Plugins-tweaks---#
#source "${ZDOTDIR}/plugin-tweaks/tweak_zsh-syntax-highlighting.zsh"

#---Vi-Mode---#
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
#function zle-keymap-select {
#    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
#        echo -ne '\e[1 q'
#    elif [[ ${KEYMAP} == main ]] || \
#        [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || \
#            [[ $1 = 'beam' ]]; then
#                echo -ne '\e[5 q'
#    fi
#}
#
#zle -N zle-keymap-select
#zle-line-init() {
#    echo -ne "\e[5 q"
#}
#
#zle -N zle-line-init
#echo -ne '\e[5 q'   # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' }    # Use beam shape cursor for each new prompt.

#---Keybinds---#
# tpr is one of my personal scripts.
bindkey -s '^P' 'tpr\n'

# other utils
source "${ZDOTDIR}/aliases"
source "${ZDOTDIR}/zshprompt"
source "/usr/share/fzf/key-bindings.zsh"
eval "$(lua ${HOME}/.local/bin/z.lua --init zsh)"

# load excutable for node version manager(nvm) on startup
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
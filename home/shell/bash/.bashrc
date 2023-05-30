#!/usr/bin/env bash

export SHELL="/usr/local/bin/bash"

export HISTFILE="${HOME}/.local/share/bash/history"
export HISTFILESIZE=
export HISTSIZE=
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="[%F %T] "

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=''
export GIT_PS1_SHOWUPSTREAM='auto'
export PROMPT_DIRTRIM=2
export PROMPT_COMMAND="prompt_main; printf '\n'; history -a; history -c; history -r"

_CReset='\e[0m'
_CRed='\e[00;31m'
_CGreen='\e[01;32m'
_CYellow='\e[00;33m'
_CBlue='\e[00;34m'

print_exit_code() {
  EXIT=$?
  [ $EXIT -ne 0 ] && printf '[\e[00;31m%s\e[0m]' "$EXIT"
}

prompt_main() {
  if __is_avail git; then
    source /usr/share/git/git-prompt.sh
    # shellcheck disable=SC2025
    PS1='in \e[00;35m\w\e[0m$(__git_ps1 " (%s)") $(print_exit_code)\n  '
  else
    # shellcheck disable=SC2025
    PS1='in \e[00;35m\w\e[0m$(print_exit_code)\n '
  fi
}

set -C
set -o vi
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s extglob
shopt -s histappend
shopt -s histverify
shopt -s checkwinsize

# unset default keybinds for these signals
stty stop undef
stty werase undef

bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'

bind "\C-l":clear-display

bind -x '"\C-o":"oldvi"'
# shellcheck disable=SC2016
bind '"\C-f":"source $HOME/.local/bin/user_scripts/fdwots"' # conditionally alters pwd
# shellcheck disable=SC2016
bind -x '"\C-s":"source $HOME/.bashrc"'

# extensions
__is_avail() { [ -z "$(command -v "$1")" ] && return 1 || return 0; }
__is_avail fzf && source "/usr/share/fzf/key-bindings.bash"
__is_avail zoxide && eval "$(zoxide init bash)"
__is_avail direnv && eval "$(direnv hook bash)"

if __is_avail vivid; then
  LS_COLORS="$(vivid generate boo)"
  export LS_COLORS
fi

source "${HOME}/dwots/home/shell/share/aliases.sh"
source "${HOME}/dwots/home/shell/share/tools.sh"
source "${HOME}/.bash_functions"


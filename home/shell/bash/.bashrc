#!/usr/bin/env bash
# shellcheck disable=1091,2025,2016

__is_avail() { [ -z "$(command -v "$1")" ] && return 1 || return 0; }

# History
export SHELL_SESSION_HISTORY=0
export HISTFILE="${HOME}/.local/share/bash/history"
export HISTFILESIZE=
export HISTSIZE=
export HISTIGNORE="?:??:exit:clear:reset:history*"
export HISTCONTROL="ignoreboth:erasedups"
export HISTTIMEFORMAT="[%F %T] "

# Prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=''
export GIT_PS1_SHOWUPSTREAM='auto'

print_exit_code() {
  EXIT=$?
  [ $EXIT -ne 0 ] && printf '[\e[00;31m%s\e[0m]' "$EXIT"
}

prompt_primary() {
  git_prompt="/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh"
  if __is_avail git && [ -f "$git_prompt" ]; then
    source "$git_prompt"
    PS1='in \e[00;35m\w\e[0m$(__git_ps1 " (%s)") $(print_exit_code)\n> '
  else
    PS1='in \e[00;35m\w\e[0m$(print_exit_code)\n '
  fi
}

export PROMPT_DIRTRIM=2
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; prompt_primary; printf '\n'"

# Options and Keybinds
set -C
set -o vi
shopt -s autocd cdspell checkwinsize direxpand dirspell dotglob extglob \
  globstar histappend histverify nocaseglob no_empty_cmd_completion

stty stop undef
stty werase undef

bind -x '"\C-s": "source $HOME/.bashrc"'
bind -x '"\C-f": "source $HOME/.local/bin/user_scripts/fdwots"'

bind -f ~/.inputrc

source "${HOME}/dwots_mac/home/shell/bash/.bash_functions"
source "${HOME}/dwots_mac/home/shell/share/aliases.sh"
# source "${HOME}/dwots_mac/home/shell/share/tools.sh"

# addons
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if __is_avail fzf && [ -f "${HOME}/.local/share/fzf/bindings.bash" ]; then
  source "${HOME}/.local/share/fzf/bindings.bash"
fi

# __is_avail direnv && eval "$(direnv hook bash)"

__is_avail zoxide && eval "$(zoxide init bash)"


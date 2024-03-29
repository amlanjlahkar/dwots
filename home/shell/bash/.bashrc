#!/usr/bin/env bash
# shellcheck disable=1091,2025

__is_avail() { [ -z "$(command -v "$1")" ] && return 1 || return 0; }

# History
export HISTFILE="${HOME}/.local/share/bash/history"
export HISTFILESIZE=
export HISTSIZE=
export HISTIGNORE="?:??:xit:clear:reset:history*:mpv*:adb*"
export HISTCONTROL="ignoreboth:erasedups"
export HISTTIMEFORMAT="[%F %T] "

# Options and Keybinds
set -C
set -o vi
shopt -s autocd cdspell checkwinsize direxpand dirspell dotglob extglob \
  globstar histappend histverify nocaseglob no_empty_cmd_completion

stty stop undef
stty werase undef

bind -x '"\C-o": "oldvi"'
# shellcheck disable=SC2016
bind -x '"\C-s": "source $HOME/.bashrc"'
# shellcheck disable=SC2016
bind -x '"\C-f": "source $HOME/.local/bin/user_scripts/fdwots"'

source "${HOME}/dwots/home/shell/bash/.bash_functions"
source "${HOME}/dwots/home/shell/share/aliases.sh"
source "${HOME}/dwots/home/shell/share/tools.sh"

# Prompt
# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWSTASHSTATE=''
# export GIT_PS1_SHOWUPSTREAM='auto'
#
# print_exit_code() {
#   EXIT=$?
#   [ $EXIT -ne 0 ] && printf '[\e[00;31m%s\e[0m]' "$EXIT"
# }
#
# prompt_primary() {
#   git_prompt="/usr/share/git/git-prompt.sh"
#   if __is_avail git && [ -f "$git_prompt" ]; then
#     source "$git_prompt"
#     PS1='in \e[00;35m\w\e[0m$(__git_ps1 " (%s)") $(print_exit_code)\n> '
#   else
#     PS1='in \e[00;35m\w\e[0m$(print_exit_code)\n '
#   fi
# }
#
# export PROMPT_DIRTRIM=2
# export PROMPT_COMMAND="history -n; history -w; history -c; history -r; prompt_primary; printf '\n'"

# Extensions
if __is_avail vivid; then
  LS_COLORS="$(vivid generate boo)"
  export LS_COLORS
fi
__is_avail fzf && source "/usr/share/fzf/key-bindings.bash"
__is_avail direnv && eval "$(direnv hook bash)"
__is_avail zoxide && eval "$(zoxide init bash)"
__is_avail starship && eval "$(starship init bash)"


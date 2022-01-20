# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

# colors
NORMAL="fg=15"
RED="fg=1"
GREEN="fg=2"
YELLOW="fg=3"
BLUE="fg=4"
MAGENTA="fg=5"
CYAN="fg=6"
BLACK="fg=0"
NORMAL_DIM="fg=7"

# default color
ZSH_HIGHLIGHT_STYLES[default]="${NORMAL}"

# unknown tokens/errors
ZSH_HIGHLIGHT_STYLES[unknown-token]="${RED}"

# commands
ZSH_HIGHLIGHT_STYLES[command]="${GREEN}"

# shell builtin commands
ZSH_HIGHLIGHT_STYLES[builtin]="${GREEN}"

# functions
ZSH_HIGHLIGHT_STYLES[reserved-word]="${GREEN}"

# keywords
ZSH_HIGHLIGHT_STYLES[reserved-word]="${CYAN}"

# command options
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="${NORMAL}"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="${NORMAL}"

# arithmatic expansions
ZSH_HIGHLIGHT_STYLES[arithmatic-expansion]="${CYAN}"

# command seprators(i.e && ;)
ZSH_HIGHLIGHT_STYLES[commandseparator]="${NORMAL}"

# aliases
ZSH_HIGHLIGHT_STYLES[alias]="${MAGENTA}"

# paths
ZSH_HIGHLIGHT_STYLES[path]="${NORMAL},underline"

# path when performing auto_cd
ZSH_HIGHLIGHT_STYLES[autodirectory]="${BLUE}"

# command substitution
ZSH_HIGHLIGHT_STYLES[command-substiution]="${RED}"
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]="${RED}"
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]="${RED}"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]="${RED}"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]="${RED}"
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]="${RED}"

# arguments
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="${RED}"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]="${RED}"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]="${RED}"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="${CYAN}"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]="${CYAN}"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="${CYAN}"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]="${CYAN}"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="${CYAN}"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]="${CYAN}"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="${RED}"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument-unclosed]="${RED}"

# others
ZSH_HIGHLIGHT_STYLES[assign]="${BLUE}"
ZSH_HIGHLIGHT_STYLES[redirection]="${GREEN}"
ZSH_HIGHLIGHT_STYLES[comments]="${NORMAL_DIM}"

# disable highlighting of globbing expressions
ZSH_HIGHLIGHT_STYLES[globbing]='none'

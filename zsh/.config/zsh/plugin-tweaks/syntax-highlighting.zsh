# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

# default color
ZSH_HIGHLIGHT_STYLES[default]='fg=#ebdbb2'

# unknown tokens/errors
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#fb4934'

# commands
ZSH_HIGHLIGHT_STYLES[command]='fg=#b8bb26'

# shell builtin commands
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#b8bb26'

# keywords
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#fe8019'

# command options
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#bdae93'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#bdae93'

# command seprators(i.e && ;)
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#83a598'

# aliases
ZSH_HIGHLIGHT_STYLES[alias]='fg=#d3869b'

# paths
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebdbb2'

# path when performing auto_cd
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#ebdbb2'

# command substitution
ZSH_HIGHLIGHT_STYLES[command-substiution]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#fabd2f'

# arguments
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#fabd2f'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#fabd2f'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#8ec07c'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#fabd2f'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument-unclosed]='fg=#fabd2f'

# disable highlighting of globbing expressions
ZSH_HIGHLIGHT_STYLES[globbing]='none'

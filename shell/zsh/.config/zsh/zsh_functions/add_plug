# Function to clone and source zsh plugins,
# as suggested by: Christian Chiarulli

function zsh_add() {
    [ -f "${ZDOTDIR}/$1" ] && source "${ZDOTDIR}/$1"
}

function zsh_plug() {
    plugin_name="${1##*\/}"
    if [ -d "${ZDOTDIR}/zsh_plugins/${plugin_name}" ]; then
        zsh_add "zsh_plugins/${plugin_name}/${plugin_name}.plugin.zsh" || zsh_add "zsh_plugins/${plugin_name}/${plugin_name}.zsh"
    else
        printf '%s\n' "Cloning plugin $plugin_name to $ZDOTDIR/zsh_plugins..."
        git clone --quiet "https://github.com/$1.git" "${ZDOTDIR}/zsh_plugins/$plugin_name"
        printf '%s\n' "Done! (open a new session for the plugin to take effect)"
    fi
}

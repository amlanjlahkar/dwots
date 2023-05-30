#!/usr/bin/env bash
#shellcheck disable=SC1091

PATH_add() {
  export PATH="$1:${PATH}"
}

# Node
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
export NPM_CONFIG_USERCONFIG="${NVM_DIR}/.npmrc"

[ -s "$NVM_DIR/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" "--no-use"
[ -s "$NVM_DIR/bash_completion" ] && \. "${NVM_DIR}/bash_completion"

# Cargo
export CARGO_HOME="${HOME}/.local/share/cargo"
export RUSTUP_HOME="${HOME}/.local/share/rustup"

PATH_add "${CARGO_HOME}/bin"

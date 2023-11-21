#!/usr/bin/env bash
#shellcheck disable=SC1091

PATH_add() {
  export PATH="$1:${PATH}"
}

data_home=${XDG_DATA_HOME:-$HOME/.local/share}

# # Node installer
# fnm_update() {
#     curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
# }
# PATH_add "${data_home}/fnm"
# eval "$(fnm env --use-on-cd)"

# Cargo
export CARGO_HOME="${data_home}/cargo"
export RUSTUP_HOME="${data_home}/rustup"

PATH_add "${CARGO_HOME}/bin"

#!/usr/bin/env bash

CONFIG_PATH="${XDG_CONFIG_HOME}/alacritty/alacritty.toml"
[ ! -e "$CONFIG_PATH" ] && exit 1

opacity=$(awk -F'= ' '/opacity/ {print $2; exit}' "$CONFIG_PATH")
case $opacity in
  1.0)
    toggle_opacity=0.94
    ;;
  *)
    toggle_opacity=1.0
    ;;
esac

sed -i -- "s/opacity = $opacity/opacity = $toggle_opacity/" "$CONFIG_PATH"

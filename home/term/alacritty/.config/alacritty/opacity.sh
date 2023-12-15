#!/usr/bin/env bash

# change alacritty window opacity

CONFIG_PATH="${XDG_CONFIG_HOME}/alacritty/alacritty.yml"
[ ! -e "$CONFIG_PATH" ] && exit 1

opacity=$(awk '$1 == "opacity:" {print $2; exit}' "$CONFIG_PATH")
case $opacity in
  1)
    toggle_opacity=0.94
    ;;
  *)
    toggle_opacity=1
    ;;
esac

sed -i -- "s/opacity: $opacity/opacity: $toggle_opacity/" "$CONFIG_PATH"

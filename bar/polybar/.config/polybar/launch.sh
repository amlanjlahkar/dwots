#!/usr/bin/env bash

# Terminate already running polybar instances
killall --quiet polybar
# if ipc is enabled for the bar(s)
#polybar-msg cmd quit

# Launch bar(s)
echo "-----" | tee --append /tmp/polybar.log
polybar simple_bar 2>&1 | tee --append /tmp/polybar.log & disown
echo "Bar launched..."

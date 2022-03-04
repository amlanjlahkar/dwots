#!/usr/bin/env bash

# script for generating herbstluftwm tags
# to be used with polybar
# copied from: https://gist.github.com/olmokramer/b28ff8ed5fd366e3ebb23b79915ec850

hash herbstclient xrandr

print_tags() {
	for tag in $(herbstclient tag_status "$1"); do
		name=${tag#?}
		state=${tag%$name}
		case "$state" in
		'#')
			printf '%%{F#c0bfbc}%%{+u}  %s  %%{F-}%%{-u}' "$name"
			;;
		'+')
			printf '%%{F#c0bfbc}  %s   %%{F-}' "$name"
			;;
		'!')
			printf '%%{R}  %s  %%{R}' "$name"
			;;
		'.')
			printf '%%{F#606665}  %s  %%{F-}' "$name"
			;;
		*)
			printf '  %s  ' "$name"
		esac
	done
	printf '\n'
}

geom_regex='[[:digit:]]\+x[[:digit:]]\++[[:digit:]]\++[[:digit:]]\+'
geom=$(xrandr --query | grep "^$MONITOR" | grep -o "$geom_regex")
monitor=$(herbstclient list_monitors | grep "$geom" | cut -d: -f1)

print_tags "$monitor"

IFS="$(printf '\t')" herbstclient --idle | while read -r hook args; do
	case "$hook" in
	tag*)
		print_tags "$monitor"
		;;
	esac
done

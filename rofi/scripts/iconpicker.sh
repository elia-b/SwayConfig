#!/usr/bin/env bash

source ~/.config/rofi/nerd-fonts/bin/scripts/lib/i_all.sh

icons=()
for var in $(compgen -v | grep '^i_'); do
  glyph="${!var}"
  icons+=("$var $glyph")
done

if [ -z "$1" ]; then
  printf "%s\n" "${icons[@]}"
else
  selected="${1#*$' '}"
  wl-copy "$selected"
fi

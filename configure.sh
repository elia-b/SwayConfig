#!/bin/bash

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

mkdir -p $HOME/.config 
mkdir -p $HOME/.local/bin

for app in mimeapps.list system-images foot ghostty waybar sway swaylock rofi dunst cmus opencode cava; do
  src="$script_dir/$app"
  tgt="$HOME/.config/$app"

  if [[ -e "$tgt" ]]; then
      echo "⚠ WARNING: $tgt already exists — not replacing"
      continue
  fi
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

rm -rf "$script_dir/rofi/nerd-fonts"
source "$script_dir/rofi/download-icons.sh"


# Add scripts to .local/bin
for app in bin/*; do
    [[ -f "$app" ]] || continue

    src="$script_dir/$app"
    tgt="$HOME/.local/$app"

    if [[ -e "$tgt" ]]; then
        echo "⚠ WARNING: $tgt already exists — not replacing"
        continue
    fi

    ln -s "$src" "$tgt"
    echo "Linked $src → $tgt"
done

for conf in .bash_profile; do
  src="$script_dir/$conf"
  tgt="$HOME/$conf"

  if [[ -e "$tgt" ]]; then
      echo "⚠ WARNING: $tgt already exists — not replacing"
      continue
  fi

  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done



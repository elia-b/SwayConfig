#!/bin/bash

script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# wofi is not used for now

for app in fontconfig alacritty waybar sway swaylock rofi dunst; do
  src="$script_dir/$app"
  tgt="$HOME/.config/$app"
  rm -rf "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done

rm -rf "$script_dir/rofi/nerd-fonts"
source "$script_dir/rofi/download-icons.sh"

for conf in .bash_profile; do
  src="$script_dir/$conf"
  tgt="$HOME/$conf"
  rm -rf "$tgt"
  ln -sf "$src" "$tgt"
  echo "Linked $src   $tgt"
done



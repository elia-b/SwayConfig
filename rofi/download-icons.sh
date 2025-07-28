#!/usr/bin/env bash

(
  script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
  cd $script_dir
  git clone --depth 1 --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git
  cd nerd-fonts
  git sparse-checkout set bin/scripts/lib
)

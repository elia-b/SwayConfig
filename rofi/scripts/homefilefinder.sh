#!/usr/bin/env bash

if [ -z "$1" ]; then
  fd --type f --hidden --no-ignore-vcs --exclude .git . ~
else
  xdg-open "$1" >/dev/null 2>&1 &
fi

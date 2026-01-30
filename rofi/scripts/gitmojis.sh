#!/usr/bin/env bash

# Path to the emoji file relative to this script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
EMOJI_FILE="$SCRIPT_DIR/gitmojis-list"

# Detect clipboard command
if command -v wl-copy >/dev/null 2>&1; then
    COPY_CMD="wl-copy"
elif command -v xclip >/dev/null 2>&1; then
    COPY_CMD="xclip -selection clipboard"
else
    echo "No clipboard utility found (wl-copy or xclip required)."
    exit 1
fi

# Read emojis into an array
icons=()
while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    main=$(echo "$line" | awk '{print $1}')
    emoji=$(echo "$line" | awk '{print $2}')
    keywords=$(echo "$line" | cut -d' ' -f1-)
    icons+=("$keywords $emoji")
done < "$EMOJI_FILE"

# Dual mode: print list or copy selected emoji
if [ -z "$1" ]; then
    # No argument → print emoji list (for Rofi)
    printf "%s\n" "${icons[@]}"
else
    # Argument passed → extract emoji (last word) and copy it
    selected="${1##* }"
    echo -n "$selected" | $COPY_CMD
fi

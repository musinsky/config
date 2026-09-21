#!/usr/bin/env bash

# 2026-09-21
# https://github.com/musinsky/config/blob/master/bash/scripts/muke-functions.sh

history_cleanup() {
  # remove duplicate lines and trailing spaces
  awk '{ sub(/ +$/, "", $0); } !seen[$0]++' "$HISTFILE" > "$HISTFILE.clean" && {
    mv "$HISTFILE" "$HISTFILE.$(date +%F_%T)"
    mv "$HISTFILE.clean" "$HISTFILE"
    history -c && history -r   # clear && read file and append
    printf "%s cleaned" "$HISTFILE"
  }
}

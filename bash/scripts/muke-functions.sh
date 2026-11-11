#!/usr/bin/env bash

# 2026-11-11
# https://github.com/musinsky/config/blob/master/bash/scripts/muke-functions.sh

file_cleanup() { # advanced
  # remove duplicate lines and trailing spaces (after specified phrase line)

  awk -v phrase="${CLEANUP_AFTER}" '
      !cleanup {
        print $0
        if (index($0, phrase)) cleanup = 1   # start cleaning after this phrase
        next
      }
      cleanup {
        sub(/[[:blank:]]+$/, "", $0)   # remove trailing spaces
        if (!seen[$0]++) print $0      # remove duplicate lines (includes !cleanup lines)
      }
  ' "${FILE}" > "${FILE}.clean" && {
    mv "${FILE}" "${FILE}.$(date +%F_%T)"
    mv "${FILE}.clean" "${FILE}"
    history -c && history -r # clear && read file and append
    printf "file: '%s' cleaned\n" "${FILE}"
  }
}

history_cleanup() { # simple
  # remove duplicate lines and trailing spaces
  awk '{ sub(/ +$/, "", $0); } !seen[$0]++' "$HISTFILE" > "$HISTFILE.clean" && {
    mv "$HISTFILE" "$HISTFILE.$(date +%F_%T)"
    mv "$HISTFILE.clean" "$HISTFILE"
    history -c && history -r # clear && read file and append
    printf "%s cleaned\n" "$HISTFILE"
  }
}

HISTFILE="${HISTFILE:-$HOME/.bash_history}"
FILE="${HISTFILE}"
CLEANUP_AFTER="# KONIEC bloku"

# pravdepodobne CLEANUP_AFTER zbytocne, kedze aj ten "header" kde si pisem "poznamky" ma splnat
# tie iste poziadavky na cistenie (max. osetrit na prazdne riadky)

#echo "$FILE"

file_cleanup
#history_cleanup

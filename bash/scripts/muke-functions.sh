#!/usr/bin/env bash

# 2026-11-21
# https://github.com/musinsky/config/blob/master/bash/scripts/muke-functions.sh

# file_cleanup() { # advanced
#   # remove duplicate lines and trailing spaces (after specified phrase line)
#   #                CLEANUP_AFTER="# KONIEC bloku"
#   awk -v phrase="${CLEANUP_AFTER}" '
#       !cleanup {
#         print $0
#         if (index($0, phrase)) cleanup = 1   # start cleaning after this phrase
#         next
#       }
#       cleanup {
#         sub(/[[:blank:]]+$/, "", $0)   # remove trailing spaces
#         if (!seen[$0]++) print $0      # remove duplicate lines (includes !cleanup lines)
#       }
#   ' "${FILE}" > "${FILE}.clean" && {
#     mv "${FILE}" "${FILE}.$(date +%F_%T)"
#     mv "${FILE}.clean" "${FILE}"
#     history -c && history -r # clear && read file and append
#     printf "file: '%s' cleaned\n" "${FILE}"
#   }
# }

file_cleanup() { # history_cleanup
  # remove trailing spaces and duplicate lines
  local file="$1"
  #local file="${1:-${HISTFILE:-$HOME/.bash_history}}"
  [[ -f "${file}" ]] || { printf "'%s' file does not exist\n" "${file}"; return 1; }

  awk '{ sub(/[[:blank:]]+$/, "", $0); } !seen[$0]++' "${file}" > "${file}.clean" && {
    mv "${file}" "${file}.$(date +%F_%T)"
    mv "${file}.clean" "${file}"

    printf "'%s' file cleaned" "${file}"
    if [[ "${file##*/}" == ".bash_history" ]]; then
      history -c && history -r # clear && read file and append
      printf " and bash history reloaded\n"
    else
      printf "\n"
    fi
  }
}

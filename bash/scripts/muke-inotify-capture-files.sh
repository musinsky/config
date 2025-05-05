#!/usr/bin/env bash

# 2025-05-05
# https://github.com/musinsky/config/blob/master/bash/scripts/muke-inotify-capture-files.sh

print_usage() {
    local bname=${0##*/}   # basename in bash
    printf 'Usage: %s DIR\n' "$bname"
    printf 'Example:\n'
    printf '   %s /var/tmp\n' "$bname"
    exit 1
}

[ "$#" -ne 1 ] && print_usage   # just one argument (dir name)
[ -d "$1" ] || { printf "'%s' dir does not exist\n" "$1"; exit 1; }

NOTIFY_DIR="$1"
NOTIFY_EVENT="close_write,moved_to"
printf "inotify (watched) dir: '%s'\n" "$NOTIFY_DIR"

TMP_DIR="$(dirname "$(mktemp --dry-run --directory)")"   # "${TMPDIR:-/tmp}"
CAPTURE_DIR="$TMP_DIR/INOTIFY_CAPTURED"
# shellcheck disable=SC2174
mkdir --parents --mode=0777 "$CAPTURE_DIR" || exit 1
printf "captured (saved) files in dir: '%s'\n\n" "$CAPTURE_DIR"

inotifywait --monitor --event "$NOTIFY_EVENT" \
            --no-newline --format '%w%f%0' \
            --exclude "$CAPTURE_DIR" --recursive "$NOTIFY_DIR" | \
    while IFS= read -r -d '' ntf_file; do
        # printf "notify file: '%s'\n" "$ntf_file"
        cp -pv --parents "$ntf_file" "$CAPTURE_DIR"
    done

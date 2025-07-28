#!/usr/bin/env bash

# 2025-07-29
# https://github.com/musinsky/config/blob/master/MidnightCommander/ext.d/image.custom.sh
# https://github.com/MidnightCommander/mc/blob/master/misc/ext.d/image.sh

action=$1   # $1 - action
filetype=$2 # $2 - type of file

[ -n "${MC_XDG_OPEN}" ] || MC_XDG_OPEN="xdg-open"

print_mc_under() {   # red color
    # only in bash (not in POSIX sh)
    local underline=$1
    for ((i=0; i < ${#underline}; i++)); do
        printf "_\b%b" "${underline:i:1}"
    done
    printf "\n"
}
print_mc_bold() {    # yellow color
    # only in bash (not in POSIX sh)
    local bold=$1
    for ((i=0; i < ${#bold}; i++)); do
        printf "%b\b%b" "${bold:i:1}" "${bold:i:1}"
    done
    printf "\n"
}
check_command() {
    local cmd=$1
    local rpm=$2
    command -v "$cmd" > /dev/null && return 0
    printf "please install '%s'\n" "$cmd"
    printf "$ sudo dnf install %s   # on Fedora/RHEL\n\n" "$rpm"
}

do_view_action() {
    local filetype=$1

    # common info for all image types
    print_mc_under "=== file ==="
    file "${MC_EXT_FILENAME}"
    printf "\n"; print_mc_under "=== identify ==="
    check_command identify ImageMagick
    # https://imagemagick.org/script/escape.php
    # https://imagemagick.org/script/fx.php
    identify -version | head --lines 1
    identify "${MC_EXT_FILENAME}"
    identify -units PixelsPerInch -format "%M %m compression type (quality): %C (%Q), depth: %z-bit, class and colorspace: %r, DPI: %[fx:round(resolution.x)]x%[fx:round(resolution.y)] (print size: %[fx:resolution.x>1?round(printsize.x*25.4):0]x%[fx:resolution.y>1?round(printsize.y*25.4):0] mm)\n" "${MC_EXT_FILENAME}"
    # printf "\n"; print_mc_under "=== exiftool ==="
    # exiftool "${MC_EXT_FILENAME}"
    # printf "\n"; print_mc_under "=== mediainfo ==="
    # mediainfo --inform_version --inform_timestamp "${MC_EXT_FILENAME}"
    printf "\n"; print_mc_under "=== exiftool & mediainfo ==="
    check_command exiftool perl-Image-ExifTool
    check_command mediainfo mediainfo
    TF1=$(mktemp) || exit 1; TF2=$(mktemp) || exit 1
    exiftool "${MC_EXT_FILENAME}" > "$TF1"
    mediainfo --inform_version --inform_timestamp "${MC_EXT_FILENAME}" > "$TF2"
    paste "$TF1" "$TF2" | \
        column --separator $'\t' --output-separator $' _\b# ' --table
    rm --force "$TF1" "$TF2"

    # additional info for specific image type
    case "${filetype}" in
        tiff)
            printf "\n"; print_mc_under "=== tiffinfo ==="
            check_command tiffinfo libtiff-tools
            tiffinfo "${MC_EXT_FILENAME}"
            ;;
        *)
            ;;
    esac
}

do_open_action() {
    local filetype=$1

    case "${filetype}" in
        *)
            printf "no open action, 'xdg-open' is used\n"
            #(eog "${MC_EXT_FILENAME}" &)
            ;;
    esac
}

case "${action}" in
    view)
        do_view_action "${filetype}"
        ;;
    open)
        ("${MC_XDG_OPEN}" "${MC_EXT_FILENAME}" >/dev/null 2>&1) || \
            do_open_action "${filetype}"
        ;;
    *)
        ;;
esac

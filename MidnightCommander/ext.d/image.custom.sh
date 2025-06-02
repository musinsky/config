#!/usr/bin/sh

# 2025-06-02
# https://github.com/musinsky/config/blob/master/MidnightCommander/ext.d/image.custom.sh
# https://github.com/MidnightCommander/mc/blob/master/misc/ext.d/image.sh

action=$1   # $1 - action
filetype=$2 # $2 - type of file

[ -n "${MC_XDG_OPEN}" ] || MC_XDG_OPEN="xdg-open"

print_mc_under() {
    # only in bash (not in POSIX sh)
    underline=$1
    for ((i=0; i < ${#underline}; i++)); do
        printf "_\b%b" "${underline:i:1}"
    done
    printf "\n"
}

do_view_action() {
    filetype=$1
    command -v identify > /dev/null || \
        { printf "please install 'identify'\n";
          printf "$ dnf install ImageMagick   # on Fedora/RHEL\n";
          printf "\n"; }
    command -v exiftool > /dev/null || \
        { printf "please install 'exiftool'\n";
          printf "$ dnf install perl-Image-ExifTool   # on Fedora/RHEL\n";
          printf "\n"; }
    command -v mediainfo > /dev/null || \
        { printf "please install 'mediainfo'\n";
          printf "$ dnf install mediainfo   # on Fedora/RHEL\n";
          printf "\n"; }

    case "${filetype}" in
        *)
            print_mc_under "=== file ==="
            file "${MC_EXT_FILENAME}"
            printf "\n"; print_mc_under "=== identify ==="
            identify -version | head --lines 1
            identify "${MC_EXT_FILENAME}"
            identify -units PixelsPerInch -format "%M %m compression quality: %Q, depth: %z-bit, class and colorspace: %r, DPI: %[fx:round(resolution.x)]x%[fx:round(resolution.y)] (print size: %[fx:printsize.x*2.54]x%[fx:printsize.y*2.54] cm)\n" "${MC_EXT_FILENAME}"
            # printf "\n"; print_mc_under "=== exiftool ==="
            # exiftool "${MC_EXT_FILENAME}"
            # printf "\n"; print_mc_under "=== mediainfo ==="
            # mediainfo --inform_version --inform_timestamp "${MC_EXT_FILENAME}"
            printf "\n"; print_mc_under "=== exiftool & mediainfo ==="
            TF1=$(mktemp) || exit 1; TF2=$(mktemp) || exit 1
            exiftool "${MC_EXT_FILENAME}" > "$TF1"
            mediainfo --inform_version --inform_timestamp "${MC_EXT_FILENAME}" > "$TF2"
            paste "$TF1" "$TF2" | \
                column --separator $'\t' --output-separator $' _\b# ' --table
            rm --force "$TF1" "$TF2"
            ;;
    esac
}

do_open_action() {
    filetype=$1

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

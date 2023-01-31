#!/usr/bin/sh

# 2023-01-31
# https://github.com/musinsky/config/blob/master/MidnightCommander/ext.d/image.custom.sh

action=$1   # $1 - action
filetype=$2 # $2 - type of file

[ -n "${MC_XDG_OPEN}" ] || MC_XDG_OPEN="xdg-open"

do_view_action() {
    filetype=$1
    command -v identify > /dev/null || \
        { printf "please install 'identify'\n";
          printf "$ dnf install ImageMagick   # on Fedora/CentOS\n";
          printf "\n"; }
    command -v exiftool > /dev/null || \
        { printf "please install 'exiftool'\n";
          printf "$ dnf install perl-Image-ExifTool   # on Fedora/CentOS\n";
          printf "\n"; }

    case "${filetype}" in
        *)
            printf "_\b=_\b=_\b= _\bf_\bi_\bl_\be _\b=_\b=_\b=\n"
            file "${MC_EXT_FILENAME}"
            printf "\n_\b=_\b=_\b= _\bi_\bd_\be_\bn_\bt_\bi_\bf_\by _\b=_\b=_\b=\n"
            identify -version | head --lines 1
            identify "${MC_EXT_FILENAME}"
            identify -units PixelsPerInch -format "%M %m compression quality: %Q, depth: %z-bit, class and colorspace: %r, DPI: %[fx:round(resolution.x)]x%[fx:round(resolution.y)] (print size: %[fx:printsize.x*2.54]x%[fx:printsize.y*2.54] cm)\n" "${MC_EXT_FILENAME}"
            printf "\n_\b=_\b=_\b= _\be_\bx_\bi_\bf_\bt_\bo_\bo_\bl _\b=_\b=_\b=\n"
            exiftool "${MC_EXT_FILENAME}"
            ;;
    esac
}

do_open_action() {
    filetype=$1

    case "${filetype}" in
        *)
            printf "do nothing, 'xdg-open' is used\n"
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

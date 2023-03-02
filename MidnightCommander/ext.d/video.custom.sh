#!/usr/bin/sh

# 2022-10-19
# https://github.com/musinsky/config/blob/master/MidnightCommander/ext.d/video.custom.sh
# https://github.com/MidnightCommander/mc/blob/master/misc/ext.d/video.sh

action=$1   # $1 - action
filetype=$2 # $2 - type of file

[ -n "${MC_XDG_OPEN}" ] || MC_XDG_OPEN="xdg-open"

do_view_action() {
    filetype=$1
    command -v mediainfo > /dev/null || \
        { printf "please install 'mediainfo'\n";
          printf "$ dnf install mediainfo   # on Fedora/CentOS\n";
          printf "\n"; }

    case "${filetype}" in
        *)
            mediainfo --inform_version --inform_timestamp "${MC_EXT_FILENAME}"
            ;;
    esac
}

do_open_action() {
    filetype=$1

    case "${filetype}" in
        *)
            printf "no open action, 'xdg-open' is used\n"
            #(vlc "${MC_EXT_FILENAME}" > /dev/null 2>&1 &)
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

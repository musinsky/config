#!/usr/bin/sh

# 2023-03-02
# https://github.com/musinsky/config/blob/master/MidnightCommander/ext.d/misc.custom.sh
# https://github.com/MidnightCommander/mc/blob/master/misc/ext.d/misc.sh.in

action=$1   # $1 - action
filetype=$2 # $2 - type of file

[ -n "${MC_XDG_OPEN}" ] || MC_XDG_OPEN="xdg-open"

print_mc_under() {
    underline=$1
    for ((i=0; i < ${#underline}; i++)); do
        printf "_\b%b" "${underline:i:1}"
    done
    printf "\n"
}

do_view_action() {
    filetype=$1

    case "${filetype}" in
        iso9660)
            isoinfo -d -i "${MC_EXT_FILENAME}" && \
                isoinfo -l -R -J -i "${MC_EXT_FILENAME}"   # WITHOUT -R and -J
            ;;
        cat)
            cat "${MC_EXT_FILENAME}"
            ;;
        lib)
            file "${MC_EXT_FILENAME}" && printf "\n";
            cat "${MC_EXT_FILENAME}"
            ;;
        ar)
            print_mc_under "=== file ==="
            file "${MC_EXT_FILENAME}"
            printf "\n"; print_mc_under "=== nm ==="
            nm -C "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        so)
            print_mc_under "=== file ==="
            file "${MC_EXT_FILENAME}"
            printf "\n"; print_mc_under "=== ldd ==="
            ldd "${MC_EXT_FILENAME}" 2>/dev/null
            printf "\n"; print_mc_under "=== nm ==="
            nm -C -D "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        elf)
            # i.e. all executable programs
            print_mc_under "=== file ==="
            file "${MC_EXT_FILENAME}"
            printf "\n"; print_mc_under "=== ldd ==="
            ldd "${MC_EXT_FILENAME}" 2>/dev/null
            printf "\n"; print_mc_under "=== nm ==="
            nm -C "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        dbf)
            file "${MC_EXT_FILENAME}"
            # dbview is dead
            ;;
        sqlite)
            file "${MC_EXT_FILENAME}" && printf "\n"
            sqlite3 "file:${MC_EXT_FILENAME}?immutable=1" .dump
            ;;
        mo)
            file "${MC_EXT_FILENAME}" && printf "\n"
            msgunfmt --indent --no-wrap "${MC_EXT_FILENAME}"
            ;;
        root)
            file "${MC_EXT_FILENAME}" && printf "\n"
            rootls --treeListing "${MC_EXT_FILENAME}"
            ;;
        torrent)
            transmission-show "${MC_EXT_FILENAME}" 2>/dev/null || \
                exiftool "${MC_EXT_FILENAME}"
            ;;
        javaclass)
            file "${MC_EXT_FILENAME}" && printf "\n"
            javap -private "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        *)
            printf "no view action\n"
            ;;
    esac
}

do_open_action() {
    filetype=$1

    case "${filetype}" in
        *)
            printf "no open action, 'xdg-open' is used\n"
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

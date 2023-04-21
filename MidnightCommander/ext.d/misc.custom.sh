#!/usr/bin/sh

# 2023-04-21
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
    print_mc_under "=== file ==="
    file "${MC_EXT_FILENAME}" && printf "\n";

    case "${filetype}" in
        iso9660)
            print_mc_under "=== isoinfo ==="
            isoinfo -d -i "${MC_EXT_FILENAME}" 2>/dev/null && \
                isoinfo -l -i "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        cat)
            cat "${MC_EXT_FILENAME}"
            ;;
        lib)
            cat "${MC_EXT_FILENAME}"
            ;;
        ar)
            print_mc_under "=== nm ==="
            nm -C "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        so)
            print_mc_under "=== ldd ==="
            ldd "${MC_EXT_FILENAME}" 2>/dev/null
            printf "\n"; print_mc_under "=== nm ==="
            nm -C -D "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        elf)
            # i.e. all executable programs
            print_mc_under "=== ldd ==="
            ldd "${MC_EXT_FILENAME}" 2>/dev/null
            printf "\n"; print_mc_under "=== nm ==="
            nm -C "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        dbf)
            # dbview is dead
            cat "${MC_EXT_FILENAME}"
            ;;
        sqlite)
            print_mc_under "=== sqlite3 ==="
            sqlite3 "file:${MC_EXT_FILENAME}?immutable=1" .dump 2>/dev/null
            ;;
        mo)
            print_mc_under "=== msgunfmt ==="
            msgunfmt --indent --no-wrap "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        root)
            print_mc_under "=== rootls ==="
            # aliases in the sub-shell are ignored
            (type rootls; printf "\n"; \
             root --version 2>&1) | awk '{print "# " $0}'; printf "\n"
            rootls --treeListing "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        torrent)
            print_mc_under "=== transmission-show ===";
            transmission-show "${MC_EXT_FILENAME}" 2>/dev/null || \
                { printf "\n"; print_mc_under "=== exiftool ===";
                  exiftool "${MC_EXT_FILENAME}" 2>/dev/null; }
            ;;
        javaclass)
            print_mc_under "=== javap ==="
            javap -private "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        font)
            print_mc_under "=== exiftool ===";
            exiftool "${MC_EXT_FILENAME}" 2>/dev/null;
            printf "\n"; print_mc_under "=== fc-query ==="
            fc-query "${MC_EXT_FILENAME}" 2>/dev/null
            ;;
        certificate)
            print_mc_under "=== openssl ===";
            openssl x509 -in "${MC_EXT_FILENAME}" -text
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

#!/usr/bin/env bash

# 2024-05-08
# https://github.com/musinsky/config/blob/master/AudioVideo/muke-mkv-touch.sh

print_usage() {
    local bname=${0##*/} # basename in bash
    printf "Usage:\n %s MOVIE.mkv\n" "$bname"
    printf "    Change 'MOVIE.mkv' file modification datetime "
    printf "to Matroska multiplex datetime.\n"
    printf " %s MOVIE-orig.mkv MOVIE-remux.mkv\n" "$bname"
    printf "    Change 'MOVIE-remux.mkv' Matroska multiplex datetime "
    printf "by 'MOVIE-orig.mkv' Matroska multiplex datetime.\n"
    printf "    File 'MOVIE-remux.mkv' will be modified "
    printf "(with current file modification datetime).\n"
    exit 1
}
check_mkv_file() {
    [[ -f "$1" ]] || { printf "'%s' file does not exist\n" "$1"; exit 1; }
    #[[ "${1##*.}" != "mkv" ]] && { printf "'%s' not mkv file\n" "$1"; exit 1; }
    file --brief --dereference "$1" | grep --quiet 'Matroska data' || \
        { printf "'%s' not Matroska data file\n" "$1"; exit 1; }
}
get_mkv_date_UTC() {
    # datime when multiplexing started
    # https://stackoverflow.com/q/36073695 (How to retrieve single value with grep from Json)
    #    "date_utc": "2009-12-10T00:21:40Z",
    mkvmerge -J "$1" | grep -oP '(?<="date_utc": ")[^"]*'
    #mkvmerge -J "$1" | jq -r '.container.properties.date_utc'
}
get_file_mdate_UTC() {
    # last modification datime of file
    date --utc --reference="$1" '+%FT%TZ'   # 2009-12-10T00:21:40Z
}
one_file() {
    # https://www.linuxjournal.com/content/return-values-bash-functions
    # https://stackoverflow.com/q/17336915 (Return value in a Bash function)
    local date_mkv
    date_mkv="$(get_mkv_date_UTC "$1")"
    [[ -z "$date_mkv" ]] && { printf "'%s' without date segment info\n" "$1"; exit 1; }
    local mdate_file
    mdate_file="$(get_file_mdate_UTC "$1")"
    printf "Matroska multiplex: "
    date --utc --date="$date_mkv"  '+%F %T %:z (%Z) => '  | tr --delete '\n'
    date       --date="$date_mkv"  '+%F %T %:z (%Z)'
    printf "file modification:  "
    date --utc --date="$mdate_file" '+%F %T %:z (%Z) => ' | tr --delete '\n'
    date       --date="$mdate_file" '+%F %T %:z (%Z)'
    [[ "$date_mkv" == "$mdate_file" ]] && \
        { printf "datetimes of '%s' are identical\n" "$1"; return; }

    touch -m --date="$date_mkv" "$1" && \
        printf "'%s' file modification datetime was changed\n" "$1"
}
two_files() {
    local date_mkv1   # source (original) file
    date_mkv1="$(get_mkv_date_UTC "$1")"
    [[ -z "$date_mkv1" ]] && { printf "'%s' without date segment info\n" "$1"; exit 1; }
    local date_mkv2   # destination (remux) file
    date_mkv2="$(get_mkv_date_UTC "$2")"
    [[ -z "$date_mkv2" ]] && { printf "'%s' without date segment info\n" "$2"; }
    printf "source (original):   '%s'\n" "$1"
    printf "Matroska multiplex:  "
    date --utc --date="$date_mkv1"  '+%F %T %:z (%Z) => '  | tr --delete '\n'
    date       --date="$date_mkv1"  '+%F %T %:z (%Z)'
    printf "destination (remux): '%s'\n" "$2"
    printf "Matroska multiplex:  "
    date --utc --date="$date_mkv2"  '+%F %T %:z (%Z) => '  | tr --delete '\n'
    date       --date="$date_mkv2"  '+%F %T %:z (%Z)'
    [[ "$date_mkv1" == "$date_mkv2" ]] && \
        { printf "datetimes of both files are identical\n"; return; }

    read -r -p "change '$2' Matroska multiplex datetime? [y]:"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkvpropedit "$2" --edit info --set "date=$date_mkv1" --quiet && \
            printf "'%s' Matroska multiplex datetime was changed\n" "$2"
    else
        printf "'%s' Matroska multiplex datetime not changed\n" "$2"
    fi
}

if [[ "$#" -eq 1 ]]; then
    check_mkv_file "$1"
    one_file "$1"
elif [[ "$#" -eq 2 ]]; then
    check_mkv_file "$1"
    check_mkv_file "$2"
    two_files "$1" "$2"
else
    print_usage
fi
printf "\n"
exit 0

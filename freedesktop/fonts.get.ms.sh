#!/usr/bin/env bash

# 2025-01-28
#
# https://learn.microsoft.com/en-us/typography/fonts/windows_10_font_list
# https://learn.microsoft.com/en-us/typography/fonts/windows_11_font_list
# https://en.wikipedia.org/wiki/List_of_typefaces_included_with_Microsoft_Windows

copy_font_file() {
    local ff_src="$1"  # [source] font file (full path)
    local ff_dir="$2"  # [destination] font dir
    local ff_file="$3" # [destination] font file (optional parameter)

    # recommended font subdir name: 'fontfoundry-fontfamily-fonts' (e.g. 'ms-calibri-fonts')
    [ -d "$ff_dir" ] || { mkdir -p "$ff_dir" || return; }
    # recommended font file name: 'FontFamily-FontStyle' (e.g. 'Calibri-BoldItalic.ttf')
    [ -z "$ff_file" ] && { # generate recommended font file name
        ff_file="$(font_auto_file_name "$ff_src")" || return
        ff_file="${ff_file}.${ff_src##*.}" # extension
    }
    ff_file="$ff_dir/$ff_file"
    #printf "source      font file: '%s'\n" "$ff_src"
    #printf "destination font file: '%s'\n" "$ff_file"
    cp -p "$ff_src" "$ff_file" && chmod 644 "$ff_file"
}
find_ms_fonts() {
    local ff_pattern="$1" # font file(s) name pattern
    local ff_sdir="$2"    # font subdir

    # find "$MS_FONTS_DIR" -type f -name "$ff_pattern" -exec printf "ff: '%s'\n" '{}' \;
    find "$MS_FONTS_DIR" -type f -name "$ff_pattern" -print0 |
        while IFS= read -r -d '' f_line; do   # -d $'\0'
            #printf "ff: '%s'\n" "$f_line"
            copy_font_file "$f_line" "$ff_sdir"
        done
}

FONTS_DIR="/usr/share/fonts"           # $XDG_DATA_DIRS, admin
FONTS_DIR="/usr/local/share/fonts"     # $XDG_DATA_DIRS, admin (recommended)
FONTS_DIR="$HOME/.local/share/fonts"   # $XDG_DATA_HOME, user (recommended)

source "$(dirname "$0")"/fonts.info.functions.sh # both scripts are in the same dir
[ -t 1 ] || { SGR_BOLD=""; SGR_COL1=""; SGR_RESET=""; } # --color=auto

MS_FONTS_DIR="/mnt/win_c/Windows/Fonts"

# https://learn.microsoft.com/en-us/typography/font-list/calibri
FONTS_SUBDIR="$FONTS_DIR/ms-calibri-fonts"
find_ms_fonts "calibri*.ttf"   "$FONTS_SUBDIR" # 6 files
fonts_summary "$FONTS_SUBDIR"

# https://learn.microsoft.com/en-us/typography/font-list/comic-sans-ms
FONTS_SUBDIR="$FONTS_DIR/ms-comic-sans-fonts"
find_ms_fonts "comic*.ttf"     "$FONTS_SUBDIR" # 4 files
fonts_summary "$FONTS_SUBDIR"

# https://learn.microsoft.com/en-us/typography/font-list/times-new-roman
FONTS_SUBDIR="$FONTS_DIR/ms-times-new-roman-fonts"
find_ms_fonts "times*.ttf"     "$FONTS_SUBDIR" # 4 files
fonts_summary "$FONTS_SUBDIR"

# https://learn.microsoft.com/en-us/typography/font-list/arial
FONTS_SUBDIR="$FONTS_DIR/ms-arial-fonts"
find_ms_fonts "arial*.ttf"     "$FONTS_SUBDIR" # 4 files
fonts_summary "$FONTS_SUBDIR"

# https://learn.microsoft.com/en-us/typography/font-list/courier-new
FONTS_SUBDIR="$FONTS_DIR/ms-courier-new-fonts"
find_ms_fonts "cour*.ttf"      "$FONTS_SUBDIR" # 4 files
fonts_summary "$FONTS_SUBDIR"

# https://learn.microsoft.com/en-us/typography/font-list/cambria
# https://learn.microsoft.com/en-us/typography/font-list/cambria-math
FONTS_SUBDIR="$FONTS_DIR/ms-cambria-fonts"
find_ms_fonts "cambria*.ttf"   "$FONTS_SUBDIR" # 3 files
copy_font_file "$MS_FONTS_DIR/cambria.ttc" \
               "$FONTS_SUBDIR" "Cambria-CambriaMath-Regular.ttc" # 1 file of 2 collection fonts
fonts_summary "$FONTS_SUBDIR"

# https://learn.microsoft.com/en-us/typography/font-list/consolas
FONTS_SUBDIR="$FONTS_DIR/ms-consolas-fonts"
find_ms_fonts "consola*.ttf"   "$FONTS_SUBDIR" # 4 files
fonts_summary "$FONTS_SUBDIR"

fc-cache && printf "fc-cache successfully done\n" 1>&2

# ToDo
# https://learn.microsoft.com/en-us/typography/font-list/aptos
# https://www.microsoft.com/en-us/download/details.aspx?id=106087
# New Office theme (see Default Office font)
# https://support.microsoft.com/en-us/office/new-office-theme-e7bbfe02-d1fb-4c4d-b3b7-6a47f0cefd3f
# Cloud fonts in Office (see Cloud fonts list)
# https://support.microsoft.com/en-us/office/cloud-fonts-in-office-f7b009fe-037f-45ed-a556-b5fe6ede6adb

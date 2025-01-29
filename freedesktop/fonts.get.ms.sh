#!/usr/bin/env bash

# 2025-01-29

copy_font_file() {
    local ff_src_full="$1" # [source] font file (full dir/file)
    local ff_dst_dir="$2"  # [destination] font dir
    local ff_dst_file="$3" # [destination] font file
    # 1st) ff_dst_file=  (empty/null) # automatically generates recommended font file
    # 2nd) ff_dst_file='same'         # same as source font file
    # 3rd) ff_dst_file='FontFile.ttf' # explicit font file

    # recommended font subdir name: 'fontfoundry-fontfamily-fonts' (e.g. 'ms-calibri-fonts')
    [ -d "$ff_dst_dir" ] || { mkdir -p "$ff_dst_dir" || return 1; }
    # recommended font file name: 'FontFamily-FontStyle' (e.g. 'Calibri-BoldItalic.ttf')
    if [ -z "$ff_dst_file" ]; then # automatically generates recommended font file
        ff_dst_file="$(font_auto_file_name "$ff_src_full")" || {
            printf "skipped font file: '%s'\n" "$ff_src_full" 1>&2
            return 1
        }
        ff_dst_file="${ff_dst_file}.${ff_src_full##*.}" # extension in bash
    elif [ "$ff_dst_file" = "same" ]; then # same as source font file
        ff_dst_file="${ff_src_full##*/}" # basename in bash
    fi

    ff_dst_file="$ff_dst_dir/$ff_dst_file" # full path
    #printf "source      font file: '%s'\n" "$ff_src_full"
    #printf "destination font file: '%s'\n" "$ff_dst_file"
    cp -p "$ff_src_full" "$ff_dst_file" && chmod 644 "$ff_dst_file"
}
find_font_files() {
    local find_dir="$1"     # [source] find starting point
    local find_pattern="$2" # [source] find name pattern (font files)
    local ff_dir="$3"       # [destination] font dir

    # find "$find_dir" -type f -name "$find_pattern" -exec printf "ff: '%s'\n" '{}' \;
    find "$find_dir" -type f -name "$find_pattern" -print0 |
        while IFS= read -r -d '' f_line; do   # -d $'\0'
            #printf "ff: '%s'\n" "$f_line"
            copy_font_file "$f_line" "$ff_dir"
        done
}

source "$(dirname "$0")"/fonts.info.functions.sh || exit 1 # both scripts are in the same dir
[ -t 1 ] || { SGR_BOLD=""; SGR_COL1=""; SGR_RESET=""; } # --color=auto

LINUX_FONTS_DIR="/usr/share/fonts"         # $XDG_DATA_DIRS/fonts, admin
LINUX_FONTS_DIR="/usr/local/share/fonts"   # $XDG_DATA_DIRS/fonts, admin (recommended)
LINUX_FONTS_DIR="$HOME/.local/share/fonts" # $XDG_DATA_HOME/fonts, user (recommended)

########## MS Windows Fonts ##########
# https://learn.microsoft.com/en-us/typography/fonts/windows_10_font_list
# https://learn.microsoft.com/en-us/typography/fonts/windows_11_font_list
# https://en.wikipedia.org/wiki/List_of_typefaces_included_with_Microsoft_Windows
MS_FONTS_DIR="/mnt/win_c/Windows/Fonts"

# https://learn.microsoft.com/en-us/typography/font-list/calibri
FONTS_DIR="$LINUX_FONTS_DIR/ms-calibri-fonts"
find_font_files "$MS_FONTS_DIR" "calibri*.ttf" "$FONTS_DIR" # 6 files
fonts_summary "$FONTS_DIR"
# https://learn.microsoft.com/en-us/typography/font-list/cambria
# https://learn.microsoft.com/en-us/typography/font-list/cambria-math
FONTS_DIR="$LINUX_FONTS_DIR/ms-cambria-fonts"
find_font_files "$MS_FONTS_DIR" "cambria*.ttf" "$FONTS_DIR" # 3 files
copy_font_file "$MS_FONTS_DIR/cambria.ttc" "$FONTS_DIR" \
               "Cambria-CambriaMath-Regular.ttc" # 1 file with 2 collection fonts
fonts_summary "$FONTS_DIR"
# https://learn.microsoft.com/en-us/typography/font-list/consolas
FONTS_DIR="$LINUX_FONTS_DIR/ms-consolas-fonts"
find_font_files "$MS_FONTS_DIR" "consola*.ttf" "$FONTS_DIR" # 4 files
fonts_summary "$FONTS_DIR"

# https://learn.microsoft.com/en-us/typography/font-list/arial
FONTS_DIR="$LINUX_FONTS_DIR/ms-arial-fonts"
find_font_files "$MS_FONTS_DIR" "arial*.ttf" "$FONTS_DIR" # 4 files
fonts_summary "$FONTS_DIR"
# https://learn.microsoft.com/en-us/typography/font-list/times-new-roman
FONTS_DIR="$LINUX_FONTS_DIR/ms-times-new-roman-fonts"
find_font_files "$MS_FONTS_DIR" "times*.ttf" "$FONTS_DIR" # 4 files
fonts_summary "$FONTS_DIR"
# https://learn.microsoft.com/en-us/typography/font-list/courier-new
FONTS_DIR="$LINUX_FONTS_DIR/ms-courier-new-fonts"
find_font_files "$MS_FONTS_DIR" "cour*.ttf"  "$FONTS_DIR" # 4 files
fonts_summary "$FONTS_DIR"
# https://learn.microsoft.com/en-us/typography/font-list/comic-sans-ms
FONTS_DIR="$LINUX_FONTS_DIR/ms-comic-sans-fonts"
find_font_files "$MS_FONTS_DIR" "comic*.ttf" "$FONTS_DIR" # 4 files
fonts_summary "$FONTS_DIR"

fc-cache && printf "fc-cache successfully done\n" 1>&2

########## MS Aptos Fonts ##########
# https://learn.microsoft.com/en-us/typography/font-list/aptos
# https://www.microsoft.com/en-us/download/details.aspx?id=106087
# file 'Microsoft Aptos Fonts.zip' (ver: 4.40, date: 6/4/2024, 2979784 bytes)

APTOS_ZIP="$HOME/Downloads/Microsoft Aptos Fonts.zip"
[ -r "$APTOS_ZIP" ] || { printf "cannot read file '%s'\n" "$APTOS_ZIP" 1>&2; exit 1; }
TMP_DIR="$(mktemp -d)" || exit 1
unzip -q "$APTOS_ZIP" -d "$TMP_DIR" || exit 1

FONTS_DIR="$LINUX_FONTS_DIR/ms-aptos-fonts"
find_font_files "$TMP_DIR" "*.ttf" "$FONTS_DIR" # 28 files
fonts_summary "$FONTS_DIR"
rm -rf "$TMP_DIR"

########## Google Fonts ##########
# https://fonts.google.com/share?selection.family=Caveat|Caveat+Brush|Exo+2|Shantell+Sans
# https://fonts.google.com/selection?family=Caveat|Caveat+Brush|Exo+2|Shantell+Sans
# https://fonts.google.com/download?family=Caveat|Caveat+Brush|Exo+2|Shantell+Sans
#
# Google changed rules (2024-03), https://github.com/google/fonts/issues/7481
# $ wget -O Caveat.zip https://fonts.google.com/download?family=Caveat # will not work

GFONTS_ZIP="$HOME/Downloads/Caveat,Caveat_Brush,Exo_2,Shantell_Sans.zip"
[ -r "$GFONTS_ZIP" ] || { printf "cannot read file '%s'\n" "$GFONTS_ZIP" 1>&2; exit 1; }
TMP_DIR="$(mktemp -d)" || exit 1
unzip -q "$GFONTS_ZIP" -d "$TMP_DIR" || exit 1

FONTS_DIR="$LINUX_FONTS_DIR/impallari-caveat-fonts"
find_font_files "$TMP_DIR/Caveat/static" "*.ttf" "$FONTS_DIR" # 4 (static) files
copy_font_file "$TMP_DIR/Caveat/Caveat-VariableFont_wght.ttf" "$FONTS_DIR" \
               "Caveat[wght].ttf" # 1 (variable) file
fonts_summary "$FONTS_DIR"

FONTS_DIR="$LINUX_FONTS_DIR/impallari-caveat-brush-fonts"
find_font_files "$TMP_DIR/Caveat_Brush" "*.ttf" "$FONTS_DIR" # 1 file
fonts_summary "$FONTS_DIR"

#rm -rf "$TMP_DIR"
#fc-cache && printf "fc-cache successfully done\n" 1>&2

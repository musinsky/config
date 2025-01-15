#!/usr/bin/env bash

# 2025-01-15
# https://github.com/musinsky/config/blob/master/freedesktop/fonts.info.functions.sh

# https://www.freedesktop.org/software/fontconfig/fontconfig-user.html
# https://www.freedesktop.org/software/fontconfig/fontconfig-devel/fcpatternformat.html
# or to same
# https://fontconfig.pages.freedesktop.org/fontconfig/fontconfig-user.html
# https://fontconfig.pages.freedesktop.org/fontconfig/fontconfig-devel/#FCPATTERNFORMAT

fonts_summary() {
    # print summary of font(s) properties
    local fl="$1" # font location (file or dir)
    local fc_fmt header

    printf "%b%s%b\n" "$SGR_BOLD" "$fl" "$SGR_RESET"
    # scan only first value of family/style/fullname, see multi-language property of font
    fc_fmt="%{file|basename}\t%{family[0]}\t%{style[0]}\t%{fullname[0]}"
    fc_fmt="$fc_fmt\t%{postscriptname}\t%{weight}\t%{variable}\n"
    #header="file\tfamily\tstyle\tfullname\tpostscriptname\tweight\tvariable"
    header="FILE\tFAMILY\tSTYLE\tFULLNAME\tPOSTSCRIPTNAME\tWEIGHT\tVARIABLE"
    # $header contains escape sequences '\t'
    (printf "%b%b%b\n" "$SGR_COL1" "$header" "$SGR_RESET"
     fc-scan --format="$fc_fmt" "$fl") |
        column --separator $'\t' --output-separator ' | ' --table
    printf "\n"
}
font_auto_file_name() {
    # generate recommended font file name
    # https://docs.fedoraproject.org/en-US/packaging-guidelines/FontsPolicy/#_style_naming
    # https://silnrsi.github.io/FDBP/en-US/Font_Naming.html # Font Development Best Practices
    local ff="$1" # font file

    [ -r "$ff" ] || { printf "cannot read file '%s'\n" "$ff" 1>&2; return 1; }
    fc-query --format="%{variable}\n" "$ff" | grep --quiet --ignore-case 'True' && \
        { printf "not for Variable Font\n" 1>&2; return 1; }
    #printf "%b%s%b\n" "$SGR_BOLD" "$ff" "$SGR_RESET" 1>&2

    # query only first value of family/style, see multi-language property of font
    fc-query --format="%{family[0]|delete( )}-%{style[0]|delete( )}\n" "$ff" # delete spaces
    return 0 # return value can be checked
}
font_version() {
    # get font version
    # !!! not always work correct !!! for example: LiberationSans-Regular.ttf
    # exiftool: Version 2.1.5, rpm: 2.1.5, this function: 2.10
    # https://silnrsi.github.io/FDBP/en-US/Versioning.html # Font Development Best Practices
    local ff="$1" # font file

    [ -r "$ff" ] || { printf "cannot read file '%s'\n" "$ff" 1>&2; return 1; }
    #printf "%b%s%b\n" "$SGR_BOLD" "$ff" "$SGR_RESET" 1>&2

    # https://stackoverflow.com/q/30613236
    fc-query --format="%{fontversion}\n" "$ff" | perl -e 'printf "%.2f\n", <>/65536.0'
    # if multi-line output (Variable Font) perl execute only one (first) line
    return 0 # return value can be checked
}
font_property_lang() {
    # Do not confuse '{property}lang' with 'lang'
    # '{property}lang' - languages corresponding to each {property} (family, style, fullname)
    # 'lang' - list of languages supported by font
    #
    # lxplus.cern.ch (RHEL 9.5, 2025-01)
    # $ fc-list :familylang=sk   --format="%{file}\n" | wc --lines => 0
    # $ fc-list :stylelang=sk    --format="%{file}\n" | wc --lines => 10
    # $ fc-list :fullnamelang=sk --format="%{file}\n" | wc --lines => 5
    # $ fc-list :lang=sk --format="%{file}\n" | wc --lines => 244

    # print multi-language property of font (languages corresponding to each {property})
    local ff="$1"        # font file
    local fproperty="$2" # font property: 'family' or 'style' or 'fullname'
    local fc_fmt ivalue nprop nlang

    [ -r "$ff" ] || { printf "cannot read file '%s'\n" "$ff" 1>&2; return 1; }
    [ -z "$fproperty" ] && fproperty='style' # property 'style' by default
    printf "%b%s%b\n" "$SGR_BOLD" "$ff" "$SGR_RESET"

    printf "== number of values for multi-language property of font\n"
    fc_fmt="#family=%{#family} \t #familylang=%{#familylang}"
    fc_fmt="$fc_fmt\n#style=%{#style} \t #stylelang=%{#stylelang}"
    fc_fmt="$fc_fmt\n#fullname=%{#fullname} \t #fullnamelang=%{#fullnamelang}\n\n"
    fc-query --format="$fc_fmt" "$ff"

    printf "== all values of font property: '%s'\n" "$fproperty"
    nprop="$(fc-query --format="%{#${fproperty}}" "$ff")"     # --format="%{#style}"
    nlang="$(fc-query --format="%{#${fproperty}lang}" "$ff")" # --format="%{#stylelang}"
    (( nprop != nlang )) && \
        { printf "#%s != #%slang\n" "$fproperty" "$fproperty" 1>&2; return 1; }
    # do not try with variable fonts, different number format of values (1111111110)
    fc-query --format="%{variable}\n" "$ff" | grep --quiet --ignore-case 'True' && \
        { printf "== Variable Font (only first value)\n"; nprop=1; nlang=1; }
    for ((ivalue=0; ivalue<nprop; ivalue++)); do
        printf "[%2d] " "$ivalue"
        fc_fmt="${fproperty}lang: %{${fproperty}lang[$ivalue]},"
        fc_fmt="$fc_fmt $fproperty: %{${fproperty}[$ivalue]}\n"
        fc-query --format="$fc_fmt" "$ff" # not effective call n-times fc-query in loop
    done
    printf "\n"

    # # examples with 'style' property (another example https://askubuntu.com/q/1236078)
    # printf "== simple\n"
    # fc-query --format="%{stylelang}\n%{style}\n\n" "$ff"
    # printf "== simple (only first value)\n"
    # fc-query --format="%{stylelang[0]}\n%{style[0]}\n\n" "$ff"
    # printf "== advanced\n"
    # fc-query --format="%{[]style,stylelang{lang: %{stylelang}, style: %{style}\n}}\n" "$ff"
}
fonts_exiftool() {
    # print exiftool summary of font(s) properties
    local fl="$1" # font location (file or dir)

    # https://exiftool.org/TagNames/Font.html
    exiftool -ExifToolVersion -Directory -FileName \
             -FontFamily -FontSubfamily -FontName -NameTableVersion -PostScriptFontName "$fl"
}

SGR_BOLD="\x1b[1m"    # bold
SGR_COL1="\x1b[1;32m" # bold green
SGR_RESET="\x1b[0m"
[ -t 1 ] || { # --color=auto (color only when standard output is connected to a terminal)
    SGR_BOLD=""; SGR_COL1=""; SGR_RESET="";
} # file descriptor 1 for standard output (fd=1 for /dev/stdout)

# # fonts_summary
# fonts_summary "/usr/share/fonts/gnu-free"

# # font_auto_file_name
# ffn="$(font_auto_file_name "/usr/share/fonts/gnu-free/FreeMonoBold.ttf")" || ffn="none"
# printf "recommended font file name: '%s'\n" "$ffn"
# ffn="$(font_auto_file_name "/usr/share/fonts/gnu-free/NonExist.ttf")" || ffn="none"
# printf "recommended font file name: '%s'\n" "$ffn"   # see also SC2155

# # font_version
# fv="$(font_version "/usr/share/fonts/gnu-free/FreeMonoBold.ttf")" || fv="n/a"
# printf "font version: '%s'\n" "$fv"   # gnu-free fonts use unusual 20120503 format version

# # font_property_lang
# font_property_lang "/usr/share/fonts/gnu-free/FreeSansBold.ttf" # "style" property by default
# font_property_lang "/usr/share/fonts/gnu-free/FreeSansBold.ttf" "fullname"

# # fonts_exiftool
# fonts_exiftool "/usr/share/fonts/gnu-free"

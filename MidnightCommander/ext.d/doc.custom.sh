#!/usr/bin/sh

# 2022-11-09
# https://github.com/musinsky/config/blob/master/MidnightCommander/ext.d/doc.custom.sh

action=$1   # $1 - action
filetype=$2 # $2 - type of file

[ -n "${MC_XDG_OPEN}" ] || MC_XDG_OPEN="xdg-open"

print_info() { printf "_\b=_\b=_\b= _\bI_\bN_\bF_\bO _\b=_\b=_\b=\n"; }
print_view() { printf "\n_\b=_\b=_\b= _\bV_\bI_\bE_\bW _\b=_\b=_\b=\n"; }

do_view_action() {
    filetype=$1
    command -v exiftool > /dev/null || \
        { printf "please install 'exiftool'\n";
          printf "$ dnf install perl-Image-ExifTool   # on Fedora/CentOS\n";
          printf "\n"; }
    if [ "${filetype}" != "pdf" ]; then
        print_info; exiftool "${MC_EXT_FILENAME}"; print_view;
    fi

    case "${filetype}" in
        ps)
            ps2ascii "${MC_EXT_FILENAME}"
            ;;
        pdf)
            print_info
            TF1=$(mktemp) || exit 1; TF2=$(mktemp) || exit 1
            pdfinfo -v 2>&1 | head --lines=1 > "$TF1"
            pdfinfo -isodates "${MC_EXT_FILENAME}" >> "$TF1"
            exiftool "${MC_EXT_FILENAME}" > "$TF2"
            paste "$TF1" "$TF2" | \
                column --separator $'\t' --output-separator '   #   ' --table
            rm --force "$TF1" "$TF2"
            print_view
            pdftotext -layout -nodiag -nopgbrk "${MC_EXT_FILENAME}" -
            ;;
        odt)
            # OpenDocument (text, spreadsheet or presentation)
            # odt2txt 0.5   # 2014-11
            odt2txt --width=-1 "${MC_EXT_FILENAME}" # extracts all OpenDocument
            #libreoffice --cat "${MC_EXT_FILENAME}" # only text document and slowly
            # LibreOffice 4.4 (2015-01-29) with new option "--cat"
            ;;
        msdoc)
            # MS Word doc(97-2003), docx(2007-365) or rtf
            # catdoc 0.95   # 2016-05
            # wv* 1.2.9     # 2010-10
            # antiword 0.37 # 2005-10
            catdoc -m 0 "${MC_EXT_FILENAME}" 2>/dev/null || \
                libreoffice --cat "${MC_EXT_FILENAME}" # docx(2007-365) but slowly
            # catdoc support only doc(97-2003) and rtf
            ;;
        msxls)
            # MS Excel xls(97-2003), xlsx(2007-365)
            # xls2csv (from catdoc package)
            xls2csv "${MC_EXT_FILENAME}" 2>/dev/null
            # xls2csv support only xls(97-2003)
            ;;
        msppt)
            # MS PowerPoint ppt(97-2003), pptx(2007-365)
            # catppt (from catdoc package)
            catppt "${MC_EXT_FILENAME}" 2>/dev/null
            # catppt support only ppt(97-2003)
            ;;
        djvu)
            djvutxt "${MC_EXT_FILENAME}"
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
            printf "do nothing, 'xdg-open' is used\n"
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

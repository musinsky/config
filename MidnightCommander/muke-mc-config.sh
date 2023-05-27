#!/usr/bin/env bash

# 2023-05-27

function print_bold {
    local sgr='\x1b[%bm'
    printf "${sgr}$1${sgr}" '1' '0'
}

function wget_file {
    wget --quiet "$1" -O "$TMP_F" || {
        echo "wget '$1' error"
        rm $TMP_F
        exit 1
    }
}

function self_upgrade {
    printf "${SGR}# script self upgrade${SGR}\n" '1' '0'
    local gfile="$GH_MC/$GH_MC_SCRIPT"
    wget_file "$gfile"
    local lfile="$0"
    cmp --silent "$TMP_F" "$lfile" || {
        echo "remote '$gfile' and local '$lfile' files are differ"
        read -r -p "overwrite file '$lfile'? [y]:"
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp --no-preserve=mode "$TMP_F" "$lfile"
            echo "now restart '$lfile' script"
            exit 0
        fi
        echo "you must upgrade/overwrite file '$lfile' and restart script"
        exit 1
    }
    echo "remote '$gfile' and local '$lfile' files are the same, no upgrade required"
}

function create_backup {
    local bfile="$1"
    [[ -f "$bfile" ]] && {
        cp --verbose --preserve "$bfile" "$bfile.$(date --reference=$bfile +%F_%T)"
    }
}

GH_MC='https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander'
GH_MC_SCRIPT='muke-mc-config.sh'
TMP_F=$(mktemp) || { echo 'mktemp error'; exit 1; }
SGR='\x1b[%bm'

printf "${SGR}# https://github.com/musinsky/config/tree/master/MidnightCommander${SGR}\n\n" '1' '0'
self_upgrade

exit

# mc global
SYSTEM_MC_ETC_DIR='/etc/mc'
SYSTEM_MC_EXT_DIR='/usr/libexec/mc/ext.d'
# mc user
MC_CONFIG_DIR="$HOME/.config/mc"
MC_EXT_DIR="$MC_CONFIG_DIR/ext.d"
MC_SKIN_DIR="$HOME/.local/share/mc/skins"

mkdir -p "$MC_CONFIG_DIR"



printf "1${SGR}=${SGR}1\n" '31' '0'
# printf "1${SGR}=${SGR}1\n" '31' '0' # musia byt zatvorky

exit


printf "${SGR}# user menu${SGR}\n" '1' '0'
create_backup "$MC_CONFIG_DIR/menu"


exit
wget "$GH_MC/mc.menu" -O "$MC_CONFIG_DIR/menu"
##wget_file "$GH_MC/mc.menu"

https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander/mc.menu -O "$HOME"/.config/mc/menu

exit




# Midnight Commander v4.8.29 (2023-01) changes in the extension file
# /etc/mc/mc.ext.ini => v4.8.29+ and 4.0 extension file format
# /etc/mc/mc.ext     => v4.8.28- and 3.0 extension file format

# v4.8.29+
MC_EXT_FILE='mc.ext.ini'
MC_EXT_FORM='mc.4.0.ext.add'
# v4.8.28-
[[ -f "$SYSTEM_MC_ETC_DIR/mc.ext" ]] && { MC_EXT_FILE='mc.ext'; MC_EXT_FORM='mc.3.0.ext.add'; }
echo "'$MC_EXT_FILE' and '$MC_EXT_FORM'"






# check if exist than backup timestamp
Create_Backup "$MC_CONFIG_DIR/$MC_EXT_FILE"

##mkdir -p "$MC_CONFIG_DIR"
### copy default extension file and add (prepend) a few extra extensions (order is important)
##wget "$GH_MC/$MC_EXT_FORM" -O - | cat - "$SYSTEM_MC_ETC_DIR/$MC_EXT_FILE" > "$MC_CONFIG_DIR/$MC_EXT_FILE"


#MC_EXT_FILE="$MC_CONFIG_DIR/$MC_EXT_FILE"
#echo "'$MC_EXT_FILE' and '$MC_EXT_FORM'"
#rm $TMP_F

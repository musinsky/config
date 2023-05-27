#!/usr/bin/env bash

# 2023-05-27
# https://github.com/musinsky/config/blob/master/MidnightCommander/muke-mc-config.sh

# shellcheck disable=SC2059
# shellcheck disable=SC2317

function wget_file { # POZRO pouizvab $1
    wget --quiet "$1" -O "$TMP_F" || {
        echo "wget '$1' error"
        rm "$TMP_F"
        exit 1
    }
}

function self_upgrade {
    printf "\n${SGR}# script self upgrade${SGR0}\n" '1'
    local gfile="$GH_MC/$GH_MC_SCRIPT"
    wget_file "$gfile"
    local lfile="$0"
    cmp --silent "$TMP_F" "$lfile" || {
        printf "'$gfile' ${SGR}!=${SGR0} '$lfile'\n" '1;31'
        read -r -p "overwrite file '$lfile'? [y]:"
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp --no-preserve=mode "$TMP_F" "$lfile"
            echo "now run the script '$lfile' again"
            exit 0
        fi
        echo "you must upgrade (overwrite) file '$lfile'"
        exit 1
    }
    printf "'$gfile' ${SGR}==${SGR0} '$lfile'\n" '1'
    printf 'no upgrade required\n'
}

function compare_copy_file {
    local gfile="$1"
    wget_file "$gfile" # volat extra pre funkciou compare_and_backup
    local lfile="$2"
    cmp --silent "$TMP_F" "$lfile" || {
        printf "'$gfile' ${SGR}!=${SGR0} '$lfile'\n" '1;31'
        create_backup "$lfile"
        cp "$TMP_F" "$lfile" && \
            printf "'$gfile' ${SGR}->${SGR0} '$lfile'\n" '1;31'
        return
    }
    printf "'$gfile' ${SGR}==${SGR0} '$lfile'\n" '1'
    printf 'no upgrade required\n'
}

function create_backup {
    local bfile="$1"
    [[ -f "$bfile" ]] && {
        cp --verbose --preserve "$bfile" "$bfile.$(date +%F_%T)"
    }
}

GH_MC='https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander'
GH_MC_SCRIPT='muke-mc-config.sh'
TMP_F=$(mktemp) || { echo 'mktemp error'; exit 1; }
SGR='\x1b[%bm'
SGR0='\x1b[0m'

## INTRO
printf "${SGR}# https://github.com/musinsky/config/tree/master/MidnightCommander${SGR0}\n" '1'

## SELF UPGRADE
# self_upgrade

# mc global
SYSTEM_MC_ETC_DIR='/etc/mc'
SYSTEM_MC_EXT_DIR='/usr/libexec/mc/ext.d'
# mc user
MC_CONFIG_DIR="$HOME/.config/mc"
MC_EXT_DIR="$MC_CONFIG_DIR/ext.d"
MC_SKIN_DIR="$HOME/.local/share/mc/skins"

mkdir -p "$MC_CONFIG_DIR"

printf "\n${SGR}# user menu file${SGR0}\n" '1'
#compare_copy_file "$GH_MC/mc.menu" "$MC_CONFIG_DIR/menu"
#chmod 644 "$MC_CONFIG_DIR/menu"


## EXTENSION
printf "\n${SGR}# extension file${SGR0}\n" '1'
# Midnight Commander v4.8.29 (2023-01) changes in the extension file
# /etc/mc/mc.ext.ini => v4.8.29+ and 4.0 extension file format
# /etc/mc/mc.ext     => v4.8.28- and 3.0 extension file format

MC_EXT_FILE='mc.ext.ini'   # v4.8.29+
MC_EXT_FORM='mc.4.0.ext.add'
if [[ -f "$SYSTEM_MC_ETC_DIR/mc.ext" ]]; then
    MC_EXT_FILE='mc.ext'   # v4.8.28-
    MC_EXT_FORM='mc.3.0.ext.add'
    echo "found '$SYSTEM_MC_ETC_DIR/$MC_EXT_FILE' => mc v4.8.28- and 3.0 extension file format"
else
    echo "found '$SYSTEM_MC_ETC_DIR/$MC_EXT_FILE' => mc v4.8.29+ and 4.0 extension file format"
fi

# copy default extension file and add (prepend) a few extra extensions (order is important)
###wget --quiet "$GH_MC/$MC_EXT_FORM" -O - | cat - "$SYSTEM_MC_ETC_DIR/$MC_EXT_FILE" > "$TMP_F"

wget_file "$GH_MC/$MC_EXT_FORM"
cat "$SYSTEM_MC_ETC_DIR/$MC_EXT_FILE" >> "$TMP_F"
MC_EXT_FILE="$MC_CONFIG_DIR/$MC_EXT_FILE" # now full path

all_script=("doc" "image" "misc" "sound" "video")
for cscript in "${all_script[@]}"
do
    echo "$cscript";
    # in extension file replace default shell scripts by customized shell scripts
    sed -i "s|$SYSTEM_MC_EXT_DIR/${cscript}.sh|$MC_EXT_DIR/${cscript}.custom.sh|g" "$TMP_F"
done
# nroff (aka simple color) "force" format mode in view mode
sed -i "/.custom.sh/s/{ascii}/{ascii,nroff}/" "$TMP_F"
exit

# sed -i "s|$SYSTEM_DIR/doc.sh|$CUSTOM_DIR/doc.custom.sh|g"     "$HOME"/.config/mc/"$MC_EXT_FILE"
# sed -i "s|$SYSTEM_DIR/image.sh|$CUSTOM_DIR/image.custom.sh|g" "$HOME"/.config/mc/"$MC_EXT_FILE"
# sed -i "s|$SYSTEM_DIR/misc.sh|$CUSTOM_DIR/misc.custom.sh|g"   "$HOME"/.config/mc/"$MC_EXT_FILE"
# sed -i "s|$SYSTEM_DIR/sound.sh|$CUSTOM_DIR/sound.custom.sh|g" "$HOME"/.config/mc/"$MC_EXT_FILE"
# sed -i "s|$SYSTEM_DIR/video.sh|$CUSTOM_DIR/video.custom.sh|g" "$HOME"/.config/mc/"$MC_EXT_FILE"

# copy customized shell scripts
SYSTEM_DIR="/usr/libexec/mc/ext.d"
CUSTOM_DIR="$HOME/.config/mc/ext.d" # or wherever you want (for example CUSTOM_DIR="$SYSTEM_DIR")
wget -N "$GH_MC"/ext.d/doc.custom.sh   -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/image.custom.sh -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/misc.custom.sh  -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/sound.custom.sh -P "$CUSTOM_DIR"
wget -N "$GH_MC"/ext.d/video.custom.sh -P "$CUSTOM_DIR"
chmod 755 "$CUSTOM_DIR"/*.custom.sh


#rm $TMP_F  !!!!!!!!!!!!

# Default shell script files are in EXTHELPERSDIR (on Fedora/CentOS
# /usr/libexec/mc/ext.d dir).

# Some customized shell script files are in /home/user/ext.d (linka na dir)
# and are compatible with Linux GNU Bash shell systems
# (tested on Fedora).

#!/usr/bin/env bash

# 2023-05-28
# https://github.com/musinsky/config/blob/master/MidnightCommander/muke-mc-config.sh

# shellcheck disable=SC2059
# shellcheck disable=SC2317

function wget_file {
    wget --quiet "$1" -O "$TMP_F" || {
        echo "wget '$1' error"; rm "$TMP_F"; exit 1
    }
}
function create_backup {
    [[ -f "$1" ]] && {
        cp --verbose --preserve "$1" "$1.$(date +%F_%T)"
    }
}
function print_section {
    printf "\n${SGR}# ${1}${SGR0}\n" '1'
}
function print_files_info {
    printf "'$1' ${SGR}${3}${SGR0} '$2'\n" '0'
}
function compare_and_copy_files {
    local f_git="$1"
    local f_local="$2"
    local f_mode="$3"
    cmp --silent "$TMP_F" "$f_local" || {
        print_files_info "$f_git" "$f_local" "!="
        create_backup "$f_local"
        cp "$TMP_F" "$f_local" && {
            chmod "$f_mode" "$f_local"
            print_files_info "$f_git" "$f_local" "->"
        }
        return
    }
    print_files_info "$f_git" "$f_local" "=="
}

function self_upgrade {
    print_section 'script self upgrade'
    local g_self="$GH_MC/muke-mc-config.sh"
    local l_self="$0"
    wget_file "$g_self"
    cmp --silent "$TMP_F" "$l_self" || {
        print_files_info "$g_self" "$l_self" "!="
        read -r -p "overwrite file '$l_self'? [y]:"
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp --no-preserve=mode "$TMP_F" "$l_self"
            echo "now run the script '$l_self' again"
            exit 0
        fi
        echo "you must upgrade (overwrite) file '$l_self'"
        exit 1
    }
    print_files_info "$g_self" "$l_self" "=="
    printf 'no upgrade required\n'
}

function menu_file {
    print_section 'user menu file'
    local g_menu="$GH_MC/mc.menu"
    local l_menu="$USER_MC_CONFIG_DIR/menu"
    wget_file "$g_menu"
    compare_and_copy_files "$g_menu" "$l_menu" "644"
}


TMP_F=$(mktemp) || { echo 'mktemp error'; exit 1; }
SGR='\x1b[%bm'
SGR0='\x1b[0m'
GH_MC='https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander'
SYSTEM_MC_ETC_DIR='/etc/mc'
USER_MC_CONFIG_DIR="$HOME/.config/mc"

## INTRO
print_section "https://github.com/musinsky/config/tree/master/MidnightCommander"
## SELF UPGRADE
#self_upgrade
mkdir -p "$USER_MC_CONFIG_DIR"
## MENU
menu_file


exit

# mc global

SYSTEM_MC_EXT_DIR='/usr/libexec/mc/ext.d'
# mc user

MC_EXT_DIR="$USER_MC_CONFIG_DIR/ext.d"
MC_SKIN_DIR="$HOME/.local/share/mc/skins"





exit



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
MC_EXT_FILE="$USER_MC_CONFIG_DIR/$MC_EXT_FILE" # now full path

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

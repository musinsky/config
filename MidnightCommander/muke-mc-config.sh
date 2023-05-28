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
    # SGR only this place (maybe local)
    printf "\n${SGR}# ${1}${SGR0}\n" '1'
}
function print_files_info {
    #local short_gh_mc="$1"
    local short_gh_mc="${1/$GH_MC/\$GH_MC}"
    #local short_home="$2"
    local short_home="${2/$HOME/\$HOME}"
    printf "'$short_gh_mc' ${SGR}${3}${SGR0} '$short_home'\n" '0'
}
function compare_and_copy_files {
    # $1 only for print
    # compare and copy always $TMP_F and $2
    ## alebo ak je TMP_F prazdny tak download, ale potom
    ## namiesto "wget_file" bude ">TMP_F", takze v podstate to iste
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
    local git_self="$GH_MC/muke-mc-config.sh"
    local user_self="$0"
    wget_file "$git_self"
    cmp --silent "$TMP_F" "$user_self" || {
        print_files_info "$git_self" "$user_self" "!="
        read -r -p "overwrite file '$user_self'? [y]:"
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp --no-preserve=mode "$TMP_F" "$user_self"
            echo "now run the script '$user_self' again"
            exit 0
        fi
        echo "you must overwrite (upgrade) file '$user_self'"
        exit 1
    }
    print_files_info "$git_self" "$user_self" "=="
    #printf 'no upgrade required\n'
}

function menu_file {
    print_section 'user menu file'
    local git_menu="$GH_MC/mc.menu"
    local user_menu="$USER_MC_CONFIG_DIR/menu"
    wget_file "$git_menu"
    compare_and_copy_files "$git_menu" "$user_menu" "644"
}

function extension_file {
    print_section 'user extension file'
    local user_ext_dir="$USER_MC_CONFIG_DIR/ext.d" # or wherever you want
    local system_ext_dir='/usr/libexec/mc/ext.d'
    mkdir -p "$user_ext_dir"
    local all_ext_script=("doc" "image" "misc" "sound" "video")
    local git_file
    local local_file
    for ext_script in "${all_ext_script[@]}"; do
        # copy customized shell scripts
        git_file="$GH_MC/ext.d/${ext_script}.custom.sh"
        local_file="$user_ext_dir/${ext_script}.custom.sh"
        wget_file "$git_file"
        compare_and_copy_files "$git_file" "$local_file" "755"
        printf "\n"
    done
    # Midnight Commander v4.8.29 (2023-01) changes in the extension file
    # /etc/mc/mc.ext.ini => v4.8.29+ and 4.0 extension file format
    # /etc/mc/mc.ext     => v4.8.28- and 3.0 extension file format
    local mc_ext_file='mc.ext.ini' # v4.8.29+
    local mc_ext_format='mc.4.0.ext.add'
    if [[ -f "$SYSTEM_MC_ETC_DIR/mc.ext" ]]; then
        mc_ext_file='mc.ext'       # v4.8.28-
        mc_ext_format='mc.3.0.ext.add'
        printf "found '$SYSTEM_MC_ETC_DIR/$mc_ext_file'"
        printf '=> mc v4.8.28- and 3.0 extension file format\n'
    else
        printf "found '$SYSTEM_MC_ETC_DIR/$mc_ext_file'"
        printf '=> mc v4.8.29+ and 4.0 extension file format\n'
    fi
    # copy default (system) extension file and add/prepend (user) extension file
    # order is important
    wget_file "$GH_MC/$mc_ext_format"                 # user
    cat "$SYSTEM_MC_ETC_DIR/$mc_ext_file" >> "$TMP_F" # user + system
    for ext_script in "${all_ext_script[@]}"; do
        # replace default shell script by customized shell script in extension file
        sed -i "s|$system_ext_dir/${ext_script}.sh|$user_ext_dir/${ext_script}.custom.sh|g" \
            "$TMP_F"
    done
    # nroff (aka simple color) "force" format mode in view mode
    sed -i "/.custom.sh/s/{ascii}/{ascii,nroff}/" "$TMP_F"

    git_file="$GH_MC/$mc_ext_format + $SYSTEM_MC_ETC_DIR/$mc_ext_file"
    local_file="$USER_MC_CONFIG_DIR/$mc_ext_file"
    compare_and_copy_files "$git_file" "$local_file" "644"

    # mozno pridat: local sc_extension=".custom.sh"
}

TMP_F=$(mktemp) || { echo 'mktemp error'; exit 1; }
SGR='\x1b[%bm'
SGR0='\x1b[0m'
GH_MC='https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander'
USER_MC_CONFIG_DIR="$HOME/.config/mc"
SYSTEM_MC_ETC_DIR='/etc/mc'

## INTRO
print_section "https://github.com/musinsky/config/tree/master/MidnightCommander"
printf "'\$GH_MC'='$GH_MC'\n"
printf "'\$HOME'='$HOME'\n"
mkdir -p "$USER_MC_CONFIG_DIR"
## SELF UPGRADE
self_upgrade
## MENU
menu_file
## EXTENSION
extension_file


rm "$TMP_F"

# MC_SKIN_DIR="$HOME/.local/share/mc/skins"

# Default shell script files are in EXTHELPERSDIR (on Fedora/CentOS
# /usr/libexec/mc/ext.d dir).

# Some customized shell script files are in /home/user/ext.d (linka na dir)
# and are compatible with Linux GNU Bash shell systems
# (tested on Fedora).

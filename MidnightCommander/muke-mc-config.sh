#!/usr/bin/env bash

# 2023-05-29
# https://github.com/musinsky/config/blob/master/MidnightCommander/muke-mc-config.sh

# shellcheck disable=SC2059

function wget_file {
    wget --quiet "$1" -O "$TMP_F" || {
        echo "wget '$1' error"; rm "$TMP_F"; exit 1
    }
}
function create_backup {
    local orig_name="$1"
    local backup_name="$1.$DATIME"
    [[ -f "$orig_name" ]] || {
        printf "'$orig_name' (does not exist)\n"
        return
    }
    cp --preserve "$orig_name" "$backup_name" && \
        printf "'$backup_name' (backup created)\n"
}
function print_section {
    # SGR only this place (maybe local)
    printf "\n${SGR}# ${1}${SGR0}\n" '1'
}
function print_files_info {
    # replace value of variable by variable name
    local short_gh_mc="${1/$GH_MC/\$GH_MC}"
    local short_home="${2/$HOME/\$HOME}"
    printf "'$short_gh_mc' ${SGR}${3}${SGR0} '$short_home'\n" '1;31'
}
function compare_and_copy_files {
    # compare and copy always $TMP_F and $2
    # $1 only for print
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
            cp --no-preserve=mode "$TMP_F" "$user_self" && {
                printf "now run the script '$user_self' again\n"
                rm "$TMP_F";
                exit 0
            }
        fi
        printf "you must overwrite (upgrade) file '$user_self'\n"
        rm "$TMP_F";
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
    local all_ext_script=("doc" "image" "misc" "sound" "video")
    local ext_script_ext='custom.sh'
    local git_file
    local local_file
    mkdir -p "$user_ext_dir"
    for ext_script in "${all_ext_script[@]}"; do
        # copy customized shell scripts
        git_file="$GH_MC/ext.d/$ext_script.$ext_script_ext"
        local_file="$user_ext_dir/$ext_script.$ext_script_ext"
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
        printf ' => mc v4.8.28- and 3.0 extension file format\n'
    else
        printf "found '$SYSTEM_MC_ETC_DIR/$mc_ext_file'"
        printf ' => mc v4.8.29+ and 4.0 extension file format\n'
    fi
    # copy default (system) extension file and add/prepend (user) extension file
    # order is important
    git_file="$GH_MC/$mc_ext_format"
    local_file="$SYSTEM_MC_ETC_DIR/$mc_ext_file"
    wget_file "$git_file"           # user
    cat "$local_file" >> "$TMP_F"   # user + system
    for ext_script in "${all_ext_script[@]}"; do
        # replace default shell script by customized shell script in extension file
        sed -i "s|$system_ext_dir/$ext_script.sh|$user_ext_dir/$ext_script.$ext_script_ext|g" \
            "$TMP_F"
    done
    # nroff (aka simple color) "force" format mode in view mode
    sed -i "/.$ext_script_ext/s/{ascii}/{ascii,nroff}/" "$TMP_F"
    git_file="$git_file + $local_file"
    local_file="$USER_MC_CONFIG_DIR/$mc_ext_file"
    compare_and_copy_files "$git_file" "$local_file" "644"
}

function skin_file {
    print_section 'user skin file'
    local user_skin_dir="$HOME/.local/share/mc/skins"
    local user_skin_file="$user_skin_dir/default-gray256.ini"
    local system_skin_dir='/usr/share/mc/skins'
    local git_skin="$GH_MC/skins/default-gray256.ini"
    wget_file "$git_skin"
    # Midnight Commander v4.8.19 (2017-03) started support
    # color aliases in the skin files
    find "$system_skin_dir" -type f -print0 | \
        xargs -0 grep --quiet '\[aliases\]' || {
        printf "not found [aliases] in '$system_skin_dir/*' files"
        printf ' => mc v4.8.19- and without aliases in skin file\n'
        # TODO: move to separate file 'default-gray256.noalias.ini'
        sed -i \
            -e 's/lightgray/color250/g' -e 's/blue/color238/g' \
            -e 's/cyan/color244/g'      -e 's/gray/color254/g' \
            -e 's/brightblue/color244/g' "$TMP_F"
        git_skin="$git_skin + no aliases"
    }
    mkdir -p "$user_skin_dir"
    compare_and_copy_files "$git_skin" "$user_skin_file" "644"
}

TMP_F=$(mktemp) || { echo 'mktemp error'; exit 1; }
DATIME=$(date +%F_%T)
SGR='\x1b[%bm'
SGR0='\x1b[0m'
GH_MC='https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander'
USER_MC_CONFIG_DIR="$HOME/.config/mc"
SYSTEM_MC_ETC_DIR='/etc/mc'
mkdir -p "$USER_MC_CONFIG_DIR"

## INTRO
print_section "https://github.com/musinsky/config/tree/master/MidnightCommander"
printf "'\$GH_MC'='$GH_MC'\n"
printf "'\$HOME'='$HOME'\n"
## SELF UPGRADE
self_upgrade
## MENU
menu_file
## EXTENSION
extension_file
## skin
skin_file

rm "$TMP_F"

# Default shell script files are in EXTHELPERSDIR (on Fedora/CentOS
# /usr/libexec/mc/ext.d dir).

# Some customized shell script files are in /home/user/ext.d (linka na dir)
# and are compatible with Linux GNU Bash shell systems
# (tested on Fedora).

#!/usr/bin/env bash

# 2023-06-18
# https://github.com/musinsky/config/blob/master/MidnightCommander/muke-mc-config.sh

function wget_file {
    wget --quiet "$1" -O "$TMP_F" || {
        echo "wget '$1' error"; rm "$TMP_F"; exit 1
    }
}
function create_backup {
    local orig_name="$1"
    local backup_name="$1.$DATIME"
    [[ -f "$orig_name" ]] || {
        printf "'%s' (does not exist)\n" "$orig_name"
        return
    }
    cp --preserve "$orig_name" "$backup_name" && \
        printf "'%s' (backup created)\n" "$backup_name"
}
function print_section {
    # SGR only this place (maybe local)
    # shellcheck disable=SC2059
    printf "\n${SGR}# ${1}${SGR0}\n" '1'
}
function print_files_info {
    # replace value of variable by variable name
    local short_gh_mc="${1/$GH_MC/\$GH_MC}"
    local short_home="${2/$HOME/\$HOME}"
    # shellcheck disable=SC2059
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
                printf "now run the script '%s' again\n" "$user_self"
                rm "$TMP_F";
                exit 0
            }
        fi
        printf "you must overwrite (upgrade) file '%s'\n" "$user_self"
        rm "$TMP_F";
        exit 1
    }
    print_files_info "$git_self" "$user_self" "=="
    #printf 'no upgrade required\n'
}

function mc_menu_file {
    print_section 'user menu file'
    local git_menu="$GH_MC/mc.menu"
    local user_menu="$USER_MC_CONFIG_DIR/menu"
    wget_file "$git_menu"
    compare_and_copy_files "$git_menu" "$user_menu" "644"
}

function mc_extension_file {
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
        printf "found '%s/%s'" "$SYSTEM_MC_ETC_DIR" "$mc_ext_file"
        printf ' => mc v4.8.28- and 3.0 extension file format\n'
    else
        printf "found '%s/%s'" "$SYSTEM_MC_ETC_DIR" "$mc_ext_file"
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

function mc_keymap_file {
    print_section 'user keymap file'
    local git_keymap="$GH_MC/mc.keymap"
    local user_keymap="$USER_MC_CONFIG_DIR/mc.keymap"
    wget_file "$git_keymap"
    compare_and_copy_files "$git_keymap" "$user_keymap" "644"
}

function mc_skin_file {
    print_section 'user skin file'
    local user_skin_dir="$USER_MC_SHARE_DIR/skins"
    local user_skin_file="$user_skin_dir/default-gray256.ini"
    local system_skin_dir='/usr/share/mc/skins'
    local git_skin="$GH_MC/skins/default-gray256.ini"

    # Midnight Commander v4.8.19 (2017-03) started support
    # color aliases in the skin files (and TrueColor)
    if find "$system_skin_dir" -type f -print0 | \
            xargs -0 grep --quiet '\[aliases\]'; then
        printf "found [aliases] in '%s/*' files" "$system_skin_dir"
        printf ' => mc v4.8.19+ with aliases in skin file\n'
    else
        git_skin="$GH_MC/skins/default-gray256.no.aliases.ini"
        printf "not found [aliases] in '%s/*' files" "$system_skin_dir"
        printf ' => mc v4.8.18- without aliases in skin file\n'
    fi
    wget_file "$git_skin"
    mkdir -p "$user_skin_dir"
    compare_and_copy_files "$git_skin" "$user_skin_file" "644"
}

function mc_ini_var_replace {
    # print_section 'user ini file'
    # local var="$1"
    local value="$2"
    local var_eq="$1="
    local var_value="$1=$2"
    local add_after_line="$3"
    local info="'${MC_INI_FILE/$HOME/\$HOME}' config line"
    # line in $MC_INI_FILE must starts with 'var=value'
    if grep --quiet "^$var_eq" "$MC_INI_FILE"; then       # var exist
        # -x, --line-regexp => var=value != var=value2
        grep --quiet -x "^$var_value" "$MC_INI_FILE" && { # with same value
            printf "%s untouched: \t'${SGR}%s${SGR0}'\n" "$info" "0" "$var_value"
            return
        }                                                 # with other value
        [[ "$MC_INI_NEED_BACKUP" ]] && {
            create_backup "$MC_INI_FILE"
            MC_INI_NEED_BACKUP=   # null (empty)
        }
        # substitute 's' (replace) line
        sed -i "s/^$var_eq.*/$var_value/" "$MC_INI_FILE"
        printf "%s modified: \t'%s${SGR}%s${SGR0}'\n" "$info" "$var_eq" "0;31" "$value"
    else                                                  # var does not exist
        # dont try without (empty) $add_after_line
        [[ "$add_after_line" ]] || {
            # shellcheck disable=SC2059
            printf "${SGR}empty${SGR0} add_after_line parameter\n" '1;31'
            return
        }
        grep --quiet "^$add_after_line" "$MC_INI_FILE" && {
            [[ "$MC_INI_NEED_BACKUP" ]] && {
                create_backup "$MC_INI_FILE"
                MC_INI_NEED_BACKUP=   # null (empty)
            }
            # append 'a' text after a line (insert 'i' text before a line)
            sed -i "/^$add_after_line.*/a $var_value" "$MC_INI_FILE"
            printf "%s added: \t'${SGR}%s${SGR0}'\n" "$info" "0;31" "$var_value"
            return
        }
        printf "%s doesn't exist: \t'${SGR}%s${SGR0}'\n" "$info" "1;31" "$add_after_line"
    fi
}

function mc_remove_all_user_files {
    # shellcheck disable=SC2059
    printf "${SGR}complete remove this user 'mc' directories${SGR0}:\n" '1;31'
    printf "'%s'\n" "$USER_MC_CONFIG_DIR"
    printf "'%s'\n" "$USER_MC_SHARE_DIR"
    printf "'%s'\n" "$HOME/.cache/mc"
    read -r -p "type [y] only if you want delete (not recommended):"
    [[ $REPLY =~ ^[Yy]$ ]] && {
        rm -rf "$USER_MC_CONFIG_DIR" "$USER_MC_SHARE_DIR" "$HOME/.cache/mc"
        printf "removed\n"
    }
}

TMP_F="$(mktemp)" || { echo 'mktemp error'; exit 1; }
DATIME="$(date +%F_%T)"   # one datime for all backups
SGR='\x1b[%bm'
SGR0='\x1b[0m'
GH_MC='https://raw.githubusercontent.com/musinsky/config/master/MidnightCommander'
USER_MC_CONFIG_DIR="$HOME/.config/mc"
USER_MC_SHARE_DIR="$HOME/.local/share/mc"
SYSTEM_MC_ETC_DIR='/etc/mc'
MC_INI_FILE="$USER_MC_CONFIG_DIR/ini"
MC_INI_NEED_BACKUP='yes' # non-null (non-empty)

print_section "https://github.com/musinsky/config/tree/master/MidnightCommander"
printf "'\$GH_MC'='%s'\n"  "$GH_MC"
printf "'\$HOME'='%s'\n\n" "$HOME"

self_upgrade
#mc_remove_all_user_files

# check ini file
[[ -f "$MC_INI_FILE" ]] || {
    printf "'%s' does not exist\n" "$MC_INI_FILE"
    printf "please run 'mc' program at least once\n"
    rm "$TMP_F"
    exit 1
}
# check running mc
# 'whoami' utility has been obsoleted and is equivalent to 'id -un'
pgrep -a -u "$(id -un)" --full "$(type -P mc)" && {
    printf "please close all running 'mc' processes\n"
    rm "$TMP_F"
    exit 1
}

mc_menu_file
mc_extension_file
mc_keymap_file
mc_skin_file
mc_ini_var_replace 'skin' 'default-gray256'

print_section 'user ini file modifications'
# parameters as regex (used by grep and sed)
mc_ini_var_replace 'timeformat_recent' '%F %T '
mc_ini_var_replace 'timeformat_old'    '%F %T•'
#mc_ini_var_replace 'timeformat_old'    '%F %T'"$(printf '\u2021')"
mc_ini_var_replace 'select_flags'      '7'

# panelize entry (mc automatically sort this entries)
mc_ini_var_replace 'muke: Find 1) empty files' \
                   'find . -type f -empty' '\[Panelize\]'
mc_ini_var_replace 'muke: Find 2) empty dirs' \
                   'find . -type d -empty' '\[Panelize\]'

rm "$TMP_F"

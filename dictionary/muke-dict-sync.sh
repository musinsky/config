#!/usr/bin/env bash

# 2026-09-23
# https://github.com/musinsky/config/blob/master/dictionary/muke-dict-sync.sh

remote_dic_curl() {
  local remote_dic="$TMP_DIR/remote.dic"
  curl -o "$remote_dic" https://raw.githubusercontent.com/musinsky/config/master/dictionary/musinsky.dic
  printf "\n"
  if cmp --silent "$remote_dic" "$DIC_USER" 2>&1; then
    printf "Remote and User dictionary: identical\n"
    rm "$remote_dic"
  else
    printf "Remote and User dictionary: different\n"
    printf "   => User dictionary replaced by Remote dictionary\n"
    cp -p "$DIC_USER" "$DIC_USER.$(date +%F_%T)" 2> /dev/null # even if $DIC_USER does not exist
    mv "$remote_dic" "$DIC_USER"
  fi
}

libre_office_link() {
  local lo_dir
  lo_dir="$(find "$HOME/.config/libreoffice" -maxdepth 2 -type d -name 'user')"
  [[ -z "$lo_dir" ]] && {
    printf "LibreOffice personal dir: not found\n"
    printf "   => first run LibreOffice\n"
    return 1
  }
  printf "LibreOffice personal dir: '%s'\n" "$lo_dir"

  local lo_dic="$lo_dir/wordbook/standard.dic"
  [[ -f "$lo_dic" && ! -L "$lo_dic" ]] && {
    # '-f' exists and is a regular file (including symbolic links)
    # '-L' exists and is a symbolic link
    printf "LibreOffice personal dictionary: regular file (not a symbolic link)\n"
    printf "   => LibreOffice dictionary file moved (backuped)\n"
    mv "$lo_dic" "$DIC_USER.LibreOffice.$(date +%F_%T)"
  }

  if [[ "$(readlink "$lo_dic")" == "$DIC_USER" ]]; then
    printf "LibreOffice dictionary link: already links to User dictionary\n"
    return
  else
    printf "LibreOffice dictionary link: not linked to User dictionary\n"
    printf "   => User dictionary linked to LibreOffice dictionary\n"
    mkdir -p "$(dirname "$lo_dic")"
    ln -s --force "$DIC_USER" "$lo_dic"
  fi
}

firefox_sync() {
  local ff_dir
  ff_dir="$(find "$HOME/.config/mozilla/firefox" -maxdepth 1 -type d -name '*.default-release')"
  [[ -z "$ff_dir" ]] && { # before Firefox 147 (released 2026-01)
    ff_dir="$(find "$HOME/.mozilla/firefox" -maxdepth 1 -type d -name '*.default-release')"
  }
  [[ -z "$ff_dir" ]] && {
    printf "Firefox personal dir: not found\n"
    printf "   => first run Firefox\n"
    return 1
  }
  printf "Firefox personal dir: '%s'\n" "$ff_dir"

  local ff_dic="$ff_dir/persdict.dat"
  local user_dic_nohead="$TMP_DIR/user.dic.nohead"
  tail -n +5 "$DIC_USER" > "$user_dic_nohead"

  [[ ! -f "$ff_dic" ]] && {
    printf "Firefox personal dictionary: not found\n"
    printf "   => User dictionary copied as Firefox dictionary\n"
    mv "$user_dic_nohead" "$ff_dic"
    return
  }

  local ff_dic_merge="$TMP_DIR/ff.dic.merge"
  if cmp --silent "$ff_dic" "$user_dic_nohead" 2>&1; then
    printf "Firefox and User dictionary: identical\n"
    rm "$user_dic_nohead"
    return
  else
    printf "Firefox and User dictionary: different\n"
    printf "   => Firefox and User dictionary synchronized\n"
    cat "$user_dic_nohead" "$ff_dic" | LC_COLLATE=C sort --unique > "$ff_dic_merge"
    mv "$ff_dic_merge" "$ff_dic"
    head -4 "$DIC_USER" > "$ff_dic_merge"
    cp -p "$DIC_USER" "$DIC_USER.Firefox.$(date +%F_%T)"
    cat "$ff_dic_merge" "$ff_dic" > "$DIC_USER"
    printf "   => \x1b[1;31mcommit or revert changes\x1b[0m, do not run this program again\n"
    rm "$user_dic_nohead"
    rm "$ff_dic_merge"
  fi
}

DIC_USER="$HOME/.musinsky.dic"
TMP_DIR="$(dirname "$(mktemp --dry-run)")" # "${TMPDIR:-/tmp}"

remote_dic_curl
printf "\n"
libre_office_link
printf "\n"
firefox_sync
printf "\n"

#!/usr/bin/env bash

# 2026-10-14

ln_or_curl_script() {
  local url="$1"
  local src dir_repo dst
  src="${url#"$RGH"/}"
  dir_repo="${src%%/*}"
  src="/home/musinsky/$dir_repo/${src#*/*/}"
  dst="/usr/local/bin/${src##*/}"
  printf "\nurl: '%s'\nsrc: '%s'\ndst: '%s'\n" "$url" "$src" "$dst"

  [[ -L "$dst" ]] && {
    printf "destination exists and is a symbolic link => do nothing\n"
    return
  }
  [[ -f "$src" ]] && {
    printf "source exists => create symbolic link to destination\n"
    ln -s --force "$src" "$dst"
    return
  }
  printf "source does not exist => curl to destination\n"
  curl -fSL "$url" -o "$dst" && chmod 755 "$dst"
}

RGH="https://raw.githubusercontent.com/musinsky"

ln_or_curl_script "$RGH/config/master/bash/scripts/muke-cvmfs-mounting.sh"
ln_or_curl_script "$RGH/config/master/dictionary/muke-dict-sync.sh"
ln_or_curl_script "$RGH/config/master/Emacs/muke-emacs-format.sh"
ln_or_curl_script "$RGH/config/master/bash/scripts/muke-inotify-capture-files.sh"
ln_or_curl_script "$RGH/config/master/MidnightCommander/muke-mc-config.sh"

ln_or_curl_script "$RGH/develop/master/translit/translit.ru.sh"
ln_or_curl_script "$RGH/develop/master/translit/translit.rename.sh"

ln_or_curl_script "$RGH/config/master/MediaWiki/wiki-backup.sh"

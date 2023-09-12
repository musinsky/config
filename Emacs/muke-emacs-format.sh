#!/usr/bin/env bash

# 2023-09-12
# https://github.com/musinsky/config/blob/master/Emacs/muke-emacs-format.sh

command -v emacs > /dev/null || { printf "'emacs' not found\n"; exit 1; }
[[ "$#" -ne 1 ]] && {
    printf 'enter just one file name\n'
    exit 1
}
[[ -f "$1" ]] || {
    printf "'%s' file does not exist\n" "$1"
    exit 1
}

FMT_FUNC='mucha-clean'
FMT_FILE="$(mktemp)" || { printf 'mktemp error\n'; exit 1; }
cat << EOF > "$FMT_FILE"
(defun $FMT_FUNC ()
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
EOF
MUKE_INIT_FILE="$HOME/.emacs.el"
grep --quiet --no-messages "$FMT_FUNC" "$MUKE_INIT_FILE" && {
    printf "muke formatting\n"
    cp "$MUKE_INIT_FILE" "$FMT_FILE"
}
cat << EOF >> "$FMT_FILE"
;; override muke init
(setq make-backup-files t)
(setq backup-directory-alist nil)
EOF

# '--batch' implies '-q' (do not load an initialization file)
# '--quick' start Emacs with minimum customizations (minimal time reduction effect)

emacs --batch --quick "$1" -l "$FMT_FILE" -f "$FMT_FUNC" -f save-buffer #&> /dev/null
rm "$FMT_FILE"

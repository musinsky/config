#!/usr/bin/env bash

# 2023-09-13
# https://github.com/musinsky/config/blob/master/Emacs/muke-emacs-format.sh

[[ "$#" -ne 1 ]] && {
    printf 'usage: %s [FILE] # just one file\n' "$0"
    exit 1
}
[[ -f "$1" ]] || {
    printf "'%s' file does not exist\n" "$1"
    exit 1
}

FMT_FUNC='muke-clean'
FMT_FILE="$(mktemp)" || { printf 'mktemp error\n'; exit 1; }
# copy user specific configuration (if exist), increases emacs execution time
cp "$HOME/.emacs.el" "$FMT_FILE" 2>/dev/null

cat << EOF >> "$FMT_FILE"
;; appended by $0
(defun $FMT_FUNC ()
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (save-buffer))
;; override user config
(setq make-backup-files t)
(setq backup-directory-alist nil)
EOF

# '--batch' implies '-q' (do not load an initialization file)
# '--quick' start emacs with minimum customizations, minimal reduction time effect

# simple test, small LaTeX file (latex-mode)
# emacs --batch         (without $HOME/.emacs.el): 0.092s
# emacs --batch --quick (without $HOME/.emacs.el): 0.088s
# emacs --batch         (with $HOME/.emacs.el):    0.295s
# emacs --batch --quick (with $HOME/.emacs.el):    0.285s

# ToDo: $ muke-emacs-format.sh sample.tex -mode=latex-mode
# emacs --batch --quick "$1" --eval="(latex-mode)" -l "$FMT_FILE" -f "$FMT_FUNC"

emacs --batch --quick "$1" -l "$FMT_FILE" -f "$FMT_FUNC" # &>/dev/null
rm "$FMT_FILE"

#!/usr/bin/env bash

# 2023-09-14
# https://github.com/musinsky/config/blob/master/Emacs/muke-emacs-format.sh

function print_usage {
    local bname=${0##*/} # basename in bash
    printf 'Usage: %s [OPTION] FILE\n' "$bname"
    printf 'Option:\n'
    printf '   -i        | load emacs user init file (default off)\n'
    printf '   -e EXPR   | evaluate the Lisp expression (default none)\n'
    printf 'Example:\n'
    printf '   %s sample.c\n' "$bname"
    printf '   %s -i -e c++-mode sample.c\n' "$bname"
    exit 1
}

while getopts ':ie:' VAL ; do
    case $VAL in
        i ) EINIT=1 ;;
        e ) EEVAL="$OPTARG" ;;
        : ) print_usage ;; # no arg
        * ) print_usage ;; # unknown option
    esac
done
shift $((OPTIND -1))

[[ "$#" -ne 1 ]] && print_usage # just one file
[[ -f "$1" ]] || { printf "'%s' file does not exist\n" "$1"; exit 1; }

FMT_FUNC='muke-clean'
FMT_FILE="$(mktemp)" || { printf 'mktemp error\n'; exit 1; }
[[ "$EINIT" ]] && {
    # emacs option '--batch' implies '-q' (do not load an initialization file)
    # load user initialization file (if exist) can increase emacs execution time
    for ifile in "$HOME/.emacs.el" "$HOME/.emacs" "$HOME/.emacs.d/init.el"; do
        # emacs looks user init file in that order
        [[ -f "$ifile" ]] && {
            cp "$ifile" "$FMT_FILE"
            printf "load user emacs init file '%s'\n" "$ifile"
            break
        }
    done
}

cat << EOF >> "$FMT_FILE"
;; appended by $0
(defun $FMT_FUNC ()
  (delete-trailing-whitespace)
  (let ((inhibit-message t))
    (indent-region (point-min) (point-max) nil))
  (untabify (point-min) (point-max))
  (save-buffer))
;; force (override user) config
;;(setq inhibit-message t) ; silent at all
(setq make-backup-files t)
(setq backup-directory-alist nil)
EOF
# In batch mode, Emacs functions like 'prin1', 'princ' and 'print' print to
# 'stdout', while 'message' and 'error' print to 'stderr'.

[[ "$EEVAL" ]] && { printf '# %seval=(%s)\n' '--' "$EEVAL"; }

emacs --batch --quick "$1" -l "$FMT_FILE" --eval="($EEVAL)" -f "$FMT_FUNC"
rm "$FMT_FILE"

# Option '--quick' start emacs with minimum customizations, but with minimal
# effect of reducing emacs execution time.
#
# simple test, small LaTeX file (latex-mode)
# emacs --batch         (no $HOME/.emacs.el)        0.095s
# emacs --batch --quick (no $HOME/.emacs.el)        0.090s
# emacs --batch         (load $HOME/.emacs.el)      0.295s
# emacs --batch --quick (load $HOME/.emacs.el)      0.285s
#
# emacs --batch --quick (load hack $HOME/.emacs.el) 0.100s
#
# In my custom init file, part with "(require 'package)" (needed for MELPA repo)
# takes about 90% of the load time and is absolutely unnecessary in batch mode.
# Use of 'noninteractive' variable (non-nil when Emacs is running in batch mode)
# as condition for loading this part, seriously reduces emacs execution time.

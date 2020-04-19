;; https://github.com/musinsky/config/tree/master/Emacs

;; notes
;; M-x toggle-input-method (C-\ to same)
;; C-q TAB (C-q insert the next character as a raw character)
;; C-u M-x ps-print-buffer
;; M-x customize, M-x customize-mode, M-x customize-face, etc
;; C-h v, C-h k, C-h ?, etc (help)

;; customize
(set-default-font "DejaVu Sans Mono-9")    ;; C-u C-x =
(set-frame-position (selected-frame) -1 0) ;; in pixels (0 0 is left top)
(set-frame-size (selected-frame) 84 60)    ;; in cols and rows
(set-face-background 'fringe "grey85")
(setq-default inhibit-eol-conversion t)    ;; see ^M (DOS line endings)
(setq-default frame-title-format (concat "%b - emacs@" (system-name)))
(setq-default column-number-mode t)
(setq-default c-basic-offset 2)
(setq-default fill-column 80)

(global-display-line-numbers-mode t)
(set-face-background 'line-number "grey95")
(set-face-foreground 'line-number "gray80")
(setq-default visible-bell t)        ;; no beeping
(setq-default indent-tabs-mode nil)  ;; no tabs (use spaces)
(windmove-default-keybindings 'meta) ;; move between windows with M key
(show-paren-mode t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq make-backup-files t)
(setq backup-directory-alist (quote (("." . "~/.emacs.d/backup"))))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(setq-default ispell-program-name "hunspell")
(setq ispell-personal-dictionary "~/.musinsky.dic")

;; auto-fill (words wrapping) mode on in all major modes
;;(setq-default auto-fill-function 'do-auto-fill)   ;; M-x auto-fill-mode

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fortran-Indent.html
(setq-default fortran-check-all-num-for-matching-do t) ;; (default nil)
(setq-default fortran-line-number-indent 5)            ;; (default 1) rigth-justify to end
;;(setq-default fortran-do-indent 1)                     ;; (default 3)
;;(setq-default fortran-if-indent 1)                     ;; (default 3)
;;(setq-default fortran-structure-indent 1)              ;; (default 3)
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fortran-Comments.html
(setq-default fortran-comment-indent-style nil)        ;; (default fixed)

;; mucha
(defun mucha-emacs-reload ()
  "Reload .emacs"
  (interactive) ;; working with M-x
  (load-file "~/.emacs"))

(defun mucha-iwb ()
  "Indent the whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)) ;; replaces tabs with spaces
  ;; (save-buffer)
  (message "mucha-iwb is done, now you can save file with C-x C-s"))

(defun mucha-russian ()
  "Russian environment"
  (interactive)
  (set-input-method "cyrillic-yawerty")
  ;; (setq ispell-dictionary "ru_RU")
  (setq ispell-dictionary "russian")
  (flyspell-mode t)
  (message "switch to russian: cyrillic-yawerty and ru_RU"))

(defun mucha-slovak ()
  "Slovak environment"
  (interactive)
  (set-input-method "slovak-prog-2")
  ;; (setq ispell-dictionary "sk-SK")
  (setq ispell-dictionary "slovak")
  (flyspell-mode t)
  (message "switch to slovak: slovak-prog-2 and sk-SK"))

(defun mucha-default-english ()
  "Default english environment"
  (interactive)
  (set-input-method nil)
  ;; (setq ispell-dictionary "en_US")
  (setq ispell-dictionary "english")
  (flyspell-mode -1)
  (message "switch to default english"))

;; CMake
(autoload 'cmake-mode "cmake-mode" t)
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

;; AUCTeX
(load "auctex.el" t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq TeX-PDF-mode t)
(setq TeX-quote-language '("russian" "<<" ">>" nil))
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill) ;; words wrapping

;; RefTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ;; hook in AUCTeX
(add-hook 'latex-mode-hook 'turn-on-reftex) ;; hook in Emacs
(setq reftex-plug-into-auctex t)

;; BibTeX
(setq bibtex-user-optional-fields
      '(("language" "Language for current bibitem")))

;; show white space
;;(setq-default show-trailing-whitespace t)
;;(set-face-background 'trailing-whitespace "red1")
;; but no similar way how show "tab whitespace"
;;
;; use library whitespace.el
;; https://github.com/emacs-mirror/emacs/blob/master/lisp/whitespace.el
;; https://www.emacswiki.org/emacs/WhiteSpace
;; M-x whitespace-mode
;; M-x whitespace-toggle-options

(global-whitespace-mode t)
(setq whitespace-style '(face trailing tabs empty)) ;; specify which kind of blank is visualized
;; visualization via face-s (used to highlight the background with a color)
;; M-x list-colors-display
(custom-set-faces
 '(whitespace-trailing ((t (:background "RosyBrown1")))) ; (set-face-background 'whitespace-trailing "gray70")
 '(whitespace-tab      ((t (:background "MistyRose1")))) ; (set-face-background 'whitespace-tab      "gray80")
 '(whitespace-empty    ((t (:background "snow2")))))     ; (set-face-background 'whitespace-empty    "gray90")

;; MELPA repository
;; M-x package-list-packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; https://github.com/musinsky/config/tree/master/Emacs

;; help: C-h b, C-h f, C-h k (C-h c), C-h v or general C-h ? (bound) F1 ?
;; keybinding help: C-h k C-x C-s => save-buffer    => M-x save-buffer
;; keybinding help: C-h k M-q     => fill-paragraph => M-x fill-paragraph
;; keybinding help: C-h k C-h k   => describe-key   => M-x describe-key
;; function help: C-h f save-buffer    => bound to C-x C-s
;; function help: C-h f fill-paragraph => bound to M-q
;; function help: C-h f describe-key   => bound to C-h k, <f1> k
;;
;; ?! setq or setq-default ?! the best way is to try it ...

;; M-x set-variable, M-x describe-variable (bound) C-h v
;; M-x eval-expression (bound) M-:
;; M-x customize-variable, M-x customize-mode, M-x customize-face, etc

;; M-q (bound) M-x fill-paragraph      => justify region
;; C-\ (bound) M-x toggle-input-method => multilingual text input
;; C-q (bound) M-x quoted-insert       => insert control char (<TAB>, <^C>)
;;
;; M-x goto-address-mode => activate URLs
;; M-x cua-mode          => use CUA keys (C-x, C-c, C-v, etc)

;; C-u => prefix argument, https://www.emacswiki.org/emacs/PrefixArgument
;; print the buffer (or region) to PostScript file (see below)
;; C-u M-x ps-print-buffer-with-faces (with-faces include color)
;; describe the character at cursor position (charset, font, etc)
;; C-u C-x = (bound) C-u M-x what-cursor-position (or M-x describe-char)

;; https://www.emacswiki.org/emacs/SetFonts
;; https://www.emacswiki.org/emacs/FrameSize
;;(set-frame-font "DejaVu Sans Mono-9") ; or via face-s (see below)
(set-frame-position (selected-frame) -1 0) ; in pixels (0 0 is left top)
(set-frame-size (selected-frame) 100 60)   ; in characters (set font before)
;; https://www.emacswiki.org/emacs/FrameTitle
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b")) " - emacs@" system-name))

;; C-x 1 => delete-other-window => maximize the current window
;; C-x 2 => split-window-below  => split the current window horizontally
;; C-x 3 => split-window-right  => split the current window vertically
;; https://www.emacswiki.org/emacs/WindMove
(windmove-default-keybindings 'meta) ; windmove with M-arrows (default is shift)
;; https://www.emacswiki.org/emacs/FrameMove

;;(setq inhibit-splash-screen t)
(global-display-line-numbers-mode t)
(setq-default indicate-empty-lines t)
(setq size-indication-mode t)
(setq visible-bell t)
(setq column-number-mode t)

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Attributes.html
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Attribute-Functions.html
;; M-x list-faces-display, M-x describe-face
(set-face-attribute 'line-number nil :background "grey90" :foreground "grey60")
(set-face-attribute 'line-number-current-line nil :background "grey80")
(set-face-attribute 'fringe nil :background "grey75")
(set-face-attribute 'region nil :background "#b3d9ff")
;;(set-face-background 'region "SkyBlue1") ; for Emacs 21+ is obsolete
;; set-face-background calling set-face-attribute (provide compatibility with older versions)
;;
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fonts.html
;;(set-face-attribute 'default nil :font "DejaVu Sans Mono-9")
;;(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 90)
;;(set-face-attribute 'default nil :height 90) ; in units of 1/10 point

(setq inhibit-eol-conversion t) ; show ^M (DOS end of line)
(show-paren-mode t)

;; https://www.emacswiki.org/emacs/ShowWhiteSpace
;;(setq-default show-trailing-whitespace t)
;;(set-face-background 'trailing-whitespace "red1")
;; but no similar way how show "tab whitespace" or "empty"
;; https://github.com/emacs-mirror/emacs/blob/master/lisp/whitespace.el
;; https://www.emacswiki.org/emacs/WhiteSpace
;; M-x whitespace-toggle-options
(global-whitespace-mode t) ; M-x global-whitespace-mode (or M-x whitespace-mode)
;; specify which kind of blank is visualized (don't use tab-mark)
(setq whitespace-style '(face trailing tabs empty))
;; visualization via face-s, M-x list-colors-display
(set-face-attribute 'whitespace-trailing nil :background "#ffb2b2")
(set-face-attribute 'whitespace-tab      nil :background "#ffecea")
(set-face-attribute 'whitespace-empty    nil :background "#ffd9d6")
;;(set-face-background 'whitespace-trailing "#ffb2b2") ; obsolete
;;(set-face-background 'whitespace-tab      "#ffecea") ; obsolete
;;(set-face-background 'whitespace-empty    "#ffd9d6") ; obsolete
;;
;; (custom-set-faces ; don't use
;;  '(whitespace-trailing ((t (:background "gray60"))))
;;  '(whitespace-tab      ((t (:background "gray75"))))
;;  '(whitespace-empty    ((t (:background "gray90")))))
;; custom-set-faces (or variables) is created, added to user-init-file by Customize Emacs
;; init file should contain ONLY ONE such instance (otherwise won't work right)

;; on Fedora default coding system is utf-8-unix (unix EOL type)
;; M-x describe-coding-system
(prefer-coding-system 'utf-8)

;; https://www.emacswiki.org/emacs/LineWrap
(setq-default fill-column 80) ; M-x set-fill-column
;; M-q (bound) M-x fill-paragraph
;; M-x set-fill-column RET 9999 (or 0) RET M-q
;;(setq-default auto-fill-function 'do-auto-fill) ; M-x auto-fill-mode
;; https://www.emacswiki.org/emacs/VisualLineMode
;;(global-visual-line-mode t) ; M-x visual-line-mode

(setq-default indent-tabs-mode nil) ; no tabs (use spaces)

(setq c-basic-offset 2)

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fortran-Indent.html
(setq fortran-check-all-num-for-matching-do t) ; (default nil)
(setq fortran-line-number-indent 5)            ; (default 1) rigth-justify to end
;;(setq fortran-do-indent 1)                     ; (default 3)
;;(setq fortran-if-indent 1)                     ; (default 3)
;;(setq fortran-structure-indent 1)              ; (default 3)
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fortran-Comments.html
(setq fortran-comment-indent-style nil)        ; (default fixed)

;; https://www.emacswiki.org/emacs/BackupDirectory
(setq make-backup-files t)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backup"))))
;;(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
;; https://www.emacswiki.org/emacs/AutoSave

;; https://github.com/emacs-mirror/emacs/blob/master/lisp/ps-print.el
;; https://www.emacswiki.org/emacs/PsPrintPackage-23
(setq ps-paper-type 'a4 ; C-u M-x ps-print-buffer-with-faces
;;;   ps-right-header nil
      ps-right-header
      (list "/pagenumberstring load"
;;;         (lambda () (format-time-string "%Y-%m-%d %H:%M:%S"))
            'ps-time-stamp-yyyy-mm-dd)
;;;   ps-print-header nil
;;;   ps-landscape-mode t
;;;   ps-number-of-columns 2
      )

(setq ispell-program-name "/usr/bin/hunspell")
(setq ispell-personal-dictionary "~/.musinsky.dic") ; don't use $HOME

;; mucha
(defun mucha-emacs-reload ()
  "Reload ~/.emacs.el init file"
  (interactive) ; working with M-x
  (load-file user-init-file)
  (message "load user init file: %s" user-init-file))

(defun mucha-clean ()
  "Clean the whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)) ; replaces tabs with spaces
  ;;(save-buffer)
  (message "mucha-clean is done, now you can save file with C-x C-s"))

(defun mucha-russian ()
  "Russian environment"
  (interactive)
  (set-input-method "cyrillic-yawerty")
  (setq ispell-dictionary "russian") ; russian = ru_RU
  (flyspell-mode 1)
  (message "switch to russian: cyrillic-yawerty and flyspell mode on"))

(defun mucha-slovak ()
  "Slovak environment"
  (interactive)
  (set-input-method "slovak-prog-2")
  (setq ispell-dictionary "slovak") ; slovak = sk_SK
  (flyspell-mode 1)
  (message "switch to slovak: slovak-prog-2 and flyspell mode on"))

(defun mucha-default-english ()
  "Default english environment"
  (interactive)
  (set-input-method nil)
  (setq ispell-dictionary nil) ; default = english = en_US
  (flyspell-mode -1)
  (message "switch to default english and flyspell mode off"))

;; MELPA repository
;; M-x package-list-packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; CMake
;; cmake-data.rpm provide /usr/share/emacs/site-lisp/site-start.d/cmake-init.el

;; AUCTeX (installed from GNU ELPA repository)
;; https://www.gnu.org/software/auctex/manual/auctex.html
(setq TeX-auto-save t)  ; parse on save
(setq TeX-parse-self t) ; parse on load
(setq-default TeX-master nil) ; query for master file

;; https://www.gnu.org/software/auctex/manual/auctex.html#Style-Files-for-Different-Languages
;; russian language style is not recognized (unlike slovak or english)
;; https://github.com/emacsmirror/auctex/blob/master/style/slovak.el
(setq TeX-quote-language '("russian" "<<" ">>" nil))

(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill) ; line wrap

;; https://www.gnu.org/software/auctex/manual/auctex.html#Selecting-and-Executing-a-Command
;; M-x customize-variable RET TeX-command-list (see various TeX-* commands)
;; see pdflatex options for default LaTeX (switch toggle prompt on)
;; C-c C-c RET LaTeX => pdflatex -file-line-error -interaction=nonstopmode file.tex
;; add these pdflatex options to $HOME/.latexmkrc (or customize pdflatex)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("mucha-make" "make" TeX-run-TeX nil ; make call latexmk
                           (latex-mode)
                           :help "Run mucha-make"))
            (add-to-list 'TeX-command-list
                         '("mucha-make-clean" "make clean" TeX-run-command nil
                           (latex-mode)
                           :help "Run mucha-make-clean"))
;;;         (setq TeX-command-default "mucha-make")
;;;         (add-hook 'after-save-hook 'TeX-command-master)
            ))

;; RefTeX (bundled with Emacs)
;; https://www.gnu.org/software/auctex/manual/reftex.html
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)

;; BibTeX (bundled with Emacs)
(setq bibtex-user-optional-fields
      '(("language" "Language for current bibitem")))

;; Emacs customize

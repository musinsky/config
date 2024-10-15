;; 2024-10-15
;; https://github.com/musinsky/config/tree/master/Emacs

;; help: C-h b, C-h f, C-h k (C-h c), C-h v or general C-h ? (bound) F1 ?
;; keybinding help: C-h k C-x C-s => save-buffer    => M-x save-buffer
;; keybinding help: C-h k M-q     => fill-paragraph => M-x fill-paragraph
;; keybinding help: C-h k C-h k   => describe-key   => M-x describe-key
;; function help: C-h f save-buffer    => bound to C-x C-s
;; function help: C-h f fill-paragraph => bound to M-q
;; function help: C-h f describe-key   => bound to C-h k, <f1> k
;; variable help: C-h v system-configuration-options
;; $ emacs -nw --batch --eval "(message system-configuration-options)" # variable
;; $ emacs -nw --batch --eval "(message (version))"                    # function
;;
;; ?! setq or setq-default ?! the best way is to try it ...

;; M-x set-variable, M-x describe-variable (bound) C-h v
;; M-x eval-expression (bound) M-:
;; M-x customize-variable, M-x customize-mode, M-x customize-face, etc

;; evaluates the Lisp expression before point and inserts the value at point
;; in the *scratch* buffer C-j (bound) M-x eval-print-last-sexp

;; M-q (bound) M-x fill-paragraph      => justify region
;; C-\ (bound) M-x toggle-input-method => multilingual text input
;; C-q (bound) M-x quoted-insert       => insert control char (<TAB>, <^C>, <^[>)
;;
;; C-x SPC (bound) M-x rectangle-mark-mode => rectangle (columns) select
;; C-x SPC (rectangle mark mode) C-t       => string rectangle (columns replace)
;;
;; M-x cua-mode => use CUA keys (C-x, C-c, C-v, etc)
;; C-RET        => start CUA enhanced rectangle support (in CUA mode)
;;
;; M-x goto-address-mode => activate URLs

;; C-u => prefix argument, https://www.emacswiki.org/emacs/PrefixArgument
;; print the buffer (or region) to PostScript file (see below)
;; C-u M-x ps-print-buffer-with-faces (with-faces include color)
;; describe the character at cursor position (charset, font name, etc)
;; C-u C-x = (bound) C-u M-x what-cursor-position (or M-x describe-char)

;;(set-frame-font "DejaVu Sans Mono-9") ; or via face-s (see below)
;; https://www.emacswiki.org/emacs/FrameSize
;; https://www.emacswiki.org/emacs/FrameTitle
(when (display-graphic-p) ; don't set-frame-size in text terminal
  (set-frame-position (selected-frame) -1 0) ; in pixels (0 0 is left top)
  (set-frame-size (selected-frame) 105 60)   ; in characters (set font before)
  (setq frame-title-format
        '((:eval (if (buffer-file-name)
                     (abbreviate-file-name (buffer-file-name))
                   "%b")) " - emacs@" system-name)))
;; works with text terminals and graphic displays together
;;(setq default-frame-alist
;;      '((left . -1) (top . 0) (width . 105) (height . 60)))

;; C-x 1 => delete-other-window => maximize the current window
;; C-x 2 => split-window-below  => split the current window horizontally
;; C-x 3 => split-window-right  => split the current window vertically
;; https://www.emacswiki.org/emacs/WindMove
(windmove-default-keybindings 'meta) ; windmove with M-arrows (default is shift)
;; https://www.emacswiki.org/emacs/FrameMove

;;(setq inhibit-splash-screen t)
(cua-mode t)
(global-display-line-numbers-mode t)
(setq-default indicate-empty-lines t)
(setq size-indication-mode t)
(setq visible-bell t)
(setq column-number-mode t)

;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Attributes.html
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Attribute-Functions.html
;; M-x list-faces-display, M-x describe-face
(set-face-attribute 'line-number nil :background "gray90" :foreground "gray60")
(set-face-attribute 'line-number-current-line nil :background "gray80")
(set-face-attribute 'fringe nil :background "gray75")
(set-face-attribute 'region nil :background "#b3d9ff")
;;(set-face-background 'region "SkyBlue1") ; for Emacs 21+ is obsolete
;; set-face-background calling set-face-attribute (provide compatibility with older versions)
(set-face-attribute 'escape-glyph nil :background "gray25" :foreground "white")
(set-face-attribute 'highlight nil :background "gray85") ; darkseagreen2 default
;; M-x hl-line-mode (face: hl-line inherit from face: highlight)
;; for column highlighting (vertical line displaying) install "vline" package from MELPA
;;
;;(set-face-attribute 'default nil :font "DejaVu Sans Mono-9")
;;(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 90)
;;(set-face-attribute 'default nil :height 90) ; in units of 1/10 point
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fonts.html
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Modifying-Fontsets.html
;; https://www.emacswiki.org/emacs/SetFonts
;; https://www.emacswiki.org/emacs/FontSets
;;
;; Emacs uses multiple fonts to represent different Unicode blocks
;; https://en.wikipedia.org/wiki/Unicode_block
;; e.g. greek or sub/super-scripts can be represented by different font
;; M-x describe-char, M-x describe-fontset, M-x describe-font, M-x describe-face
;; choose (install, set) appropriate fonts
;; ;; U+2070..U+209F Superscripts and Subscripts Unicode block
;; (set-fontset-font "fontset-default" '(#x2070 . #x209f) "Noto Sans Mono")
;; ;; U+0370..U+03FF Greek and Coptic Unicode block
;; (set-fontset-font "fontset-default"
;;                   (cons (decode-char 'ucs #x0370)
;;                         (decode-char 'ucs #x03ff))
;;                   "Source Code Pro Bold")

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
;; https://www.emacswiki.org/emacs/FillParagraph
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fill-Commands.html
;; M-x display-fill-column-indicator-mode
(setq-default fill-column 80) ; M-x set-fill-column
;; M-q (bound) M-x fill-paragraph
;; M-x set-fill-column RET 9999 (or 0) RET M-q
;; C-u M-q => block fill paragraph (M-1 M-q faster to type)
(setq sentence-end-double-space nil) ; fill paragraph with a single space (not double)
;;(setq-default auto-fill-function 'do-auto-fill) ; M-x auto-fill-mode
;; https://www.emacswiki.org/emacs/VisualLineMode
;;(global-visual-line-mode t) ; M-x visual-line-mode

(setq-default indent-tabs-mode nil) ; no tabs (use spaces)

;; https://github.com/emacs-mirror/emacs/blob/master/lisp/progmodes/sh-script.el
;;(setq sh-basic-offset 2) ; default 4

;; https://www.gnu.org/software/emacs/manual/html_mono/ccmode.html
(setq c-basic-offset 2)
(add-hook 'c-mode-hook
          (lambda ()
            ;; toggle from block comments to line comments
            (c-toggle-comment-style -1)              ; from Emacs 26.1 (2018-05)
;;;         (setq comment-start "//" comment-end "") ; old solution
            ))

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fortran-Indent.html
(setq fortran-check-all-num-for-matching-do t) ; (default nil)
(setq fortran-line-number-indent 5)            ; (default 1) rigth-justify to end
;;(setq fortran-do-indent 1)                     ; (default 3)
;;(setq fortran-if-indent 1)                     ; (default 3)
;;(setq fortran-structure-indent 1)              ; (default 3)
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fortran-Comments.html
(setq fortran-comment-indent-style nil)        ; (default fixed)

;; https://www.flycheck.org/en/latest/languages.html#fortran
(setq flycheck-gfortran-language-standard nil) ; don't use "-std" option at all
;; gfortran default value for std is "gnu", flycheck default value is "f95"
;;(add-hook 'fortran-mode-hook
;;          (lambda ()
;;            (setq flycheck-gfortran-language-standard "gnu")))

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

;; mucha (user functions)
(defun mucha-emacs-reload ()
  "Reload ~/.emacs.el init file"
  (interactive) ; working with M-x
  (load-file user-init-file)
  (message "Load user init file: %s" user-init-file))

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
  (message "Switch to russian: cyrillic-yawerty and flyspell mode on"))

(defun mucha-slovak ()
  "Slovak environment"
  (interactive)
  (set-input-method "slovak-prog-2")
  (setq ispell-dictionary "slovak") ; slovak = sk_SK
  (flyspell-mode 1)
  (message "Switch to slovak: slovak-prog-2 and flyspell mode on"))

(defun mucha-slovak-ascii ()
  "Slovak ASCII environment"
  (interactive)
  (set-input-method nil)
  (setq ispell-dictionary "sk_SK-ascii") ; slovak ascii
  (flyspell-mode 1)
  (message "Switch to slovak ascii and flyspell mode on"))

(defun mucha-default-english ()
  "Default english environment"
  (interactive)
  (set-input-method nil)
  (setq ispell-dictionary nil) ; default = english = en_US
  (flyspell-mode -1)
  (message "Switch to default english and flyspell mode off"))

;; https://www.emacswiki.org/emacs/FindingNonAsciiCharacters
(defun find-next-non-ascii-char ()
  "Find next non-ascii character from point onwards"
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
      (message "No non-ascii characters"))))

(defun find-all-non-ascii-char ()
  "Find all non-ascii characters in the current buffer"
  (interactive)
  (occur "[[:nonascii:]]"))

(defun display-ansi-colors ()
  "Colorize the full buffer containing SGR control sequences"
  (require 'ansi-color)
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Package-Menu.html
;; M-x list-packages (or alias) M-x package-list-packages
;; type 'U' (mark Upgradable packages) and then 'x' (eXecute installs and deletions)
;; MELPA repository
(unless noninteractive   ; variable is non-nil when Emacs is running in batch mode
  ;; this part takes about 90% of the emacs load time in batch mode
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  ;; (add-to-list 'package-archives
  ;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (package-initialize))

;; CMake
;; "cmake-data.rpm" provide /usr/share/emacs/site-lisp/site-start.d/cmake-init.el

;; Flycheck (package "flycheck" installed from MELPA repository)
;; https://www.flycheck.org
;;(add-hook 'after-init-hook #'global-flycheck-mode)
;; M-x flycheck-mode

;; Eglot, Emacs Polyglot (package "eglot" installed from GNU ELPA repository)
;; https://github.com/joaotavora/eglot
;; M-x eglot   # "clangd" ("clang-tools-extra.rpm") is required for C/C++ support
;; Emacs 29.1 (2023-07) with built-in Eglot package

;; Markdown Mode (package "markdown-mode" installed from MELPA repository)
;; https://jblevins.org/projects/markdown-mode/
;; markdown-mode and/or gfm-mode are autoloaded

;; sql-indent (package "sql-indent" installed from GNU ELPA repository)
;; https://www.emacswiki.org/emacs/SqlIndent
;; sql-mode will automatically use sql-indent when it’s installed

;; apache-mode (package "apache-mode" installed from MELPA repository)
;; https://github.com/emacs-php/apache-mode
;; M-x apache-mode

;; AUCTeX (package "auctex" installed from GNU ELPA repository)
;; https://www.gnu.org/software/auctex/manual/auctex.html
(setq TeX-auto-save t)        ; parse on save
(setq TeX-parse-self t)       ; parse on load
(setq-default TeX-master nil) ; query for master file
(setq TeX-PDF-mode t)         ; from AUCTeX 11.88 enabled by default

;; https://www.gnu.org/software/auctex/manual/auctex.html#Style-Files-for-Different-Languages
;; russian language style is not recognized (unlike slovak or english)
;; https://github.com/emacsmirror/auctex/blob/master/style/slovak.el
(setq TeX-quote-language '("russian" "<<" ">>" nil))

(setq LaTeX-syntactic-comments nil)            ; don't indent, format comments
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill) ; line wrap

;; https://www.gnu.org/software/auctex/manual/auctex.html#Forward-and-Inverse-Search
;; forward search from Emacs to Evince => C-c C-v (bound) M-x TeX-view
;; inverse search from Evince to Emacs => Ctrl + left click
(setq TeX-source-correlate-mode t)         ; i.a. add option "-synctex=1" for pdflatex
(setq TeX-source-correlate-start-server t) ; however inverse search works also with nil ?!

;; https://www.gnu.org/software/auctex/manual/auctex.html#Selecting-and-Executing-a-Command
;; M-x customize-variable RET TeX-command-list (examine various commands with options)
;; see pdflatex options for default LaTeX command (switch toggle prompt on)
;; C-c C-c LaTeX => command: pdflatex -file-line-error -interaction=nonstopmode file.tex
;; add these pdflatex options to $HOME/.latexmkrc or customize pdflatex command with options
;; only with these options AUCTeX can forward/inverse search, catching the errors, etc.
;; https://github.com/tom-tan/auctex-latexmk # LatexMk support to AUCTeX (clean solution)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         ;; pdflatex options are stored in Makefile (or via $HOME/.latexmkrc)
                         '("mucha-make" "make" ; make call latexmk
                           TeX-run-TeX nil     ; (nil or t) switch toggle prompt
                           (latex-mode) :help "Run mucha-make"))
            (add-to-list 'TeX-command-list
                         ;; pdflatex options set with command argument $ make OPT="auctex options"
                         '("mucha-make-opt" "make OPT=\"%(file-line-error) %(extraopts) %S %(mode)\""
                           TeX-run-TeX nil
                           (latex-mode) :help "Run mucha-make-opt"))
            (add-to-list 'TeX-command-list
                         '("mucha-make-clean" "make clean"
                           TeX-run-command nil
                           (latex-mode) :help "Run mucha-make-clean"))
;;;         (setq TeX-command-default "mucha-make-opt")
;;;         (add-hook 'after-save-hook 'TeX-command-master)
            ))

;; https://www.gnu.org/software/auctex/manual/auctex.html#Controlling-Screen-Display
;; M-x customize-group RET font-latex (Font-latex text highlighting package)
(setq font-latex-fontify-sectioning (quote color)) ; only color
(setq font-latex-script-display (quote (nil)))     ; _sub/^super-script on baseline
;;(setq font-latex-fontify-script nil)             ; _sub/^super-script disable at all
(setq tex-fontify-script nil)                      ; _sub/^super-script in Emacs latex mode

;; RefTeX (bundled with Emacs)
;; https://www.gnu.org/software/auctex/manual/reftex.html
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t)

;; BibTeX (bundled with Emacs)
(setq bibtex-user-optional-fields
      '(("language" "Language for current bibitem")))

;; Emacs customize (options saved by emacs)

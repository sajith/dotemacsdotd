;; -*- emacs-lisp -*-
;;
;; The very raw very ugly .emacs
;;
;; Started sometime in January 2004.
;; Collected cruft through the years.
;; Updated to use use-package in June 2016.
;;

;; ---------------------------------------------------------------------

;; (setq debug-on-error t)

(setq
 user-full-name    "Sajith Sasidharan"
 user-mail-address "sajith@hcoop.net")

;; ---------------------------------------------------------------------

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(blink-cursor-mode 0)

(global-font-lock-mode           t)
(display-time-mode               t)
(column-number-mode              t)
(line-number-mode                t)
(transient-mark-mode             t)
(show-paren-mode                 t)
;; (desktop-save-mode               nil)
(savehist-mode                   t)
(prefer-coding-system            'utf-8)
(display-battery-mode            t)
(cua-selection-mode              t)
(global-hl-line-mode             t)

(setq-default
 inhibit-startup-message         t
 save-place                      t
 tab-always-indent               'complete
 tab-width                       8
 indent-tabs-mode                nil  ; Indentation cannot insert tabs
 ring-bell-function              'ignore
 cua-auto-tabify-rectangles      nil
 global-auto-revert-mode         t
 require-final-newline           t
 font-lock-maximum-decoration    t
 dired-dwim-target               t

 uniquify-buffer-name-style      'forward

 vc-make-backup-files            nil

 ;; Do not leave emacs mistakenly.
 confirm-kill-emacs              'yes-or-no-p

 ;; https://www.emacswiki.org/emacs/BackupDirectory
 backup-by-copying               t
 backup-directory-alist          '(("." . "~/.emacs.d/backups"))
 delete-old-versions             t
 kept-new-versions               6
 kept-old-versions               2
 version-control                 t

 enable-local-variables          :safe
 )

;; ---------------------------------------------------------------------

;; Tree-sitter language grammars.  Emacs 29+ comes with built-in
;; support for tree-sitter, but for licensing reasons, does not ship
;; with the actual language grammars. We have to download and compile
;; them ourselves.
;;
;; Run M-x treesit-install-language-grammar to install.
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/tree-sitter/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Volgan_J.nv/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/tree-sitter/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))


;; ---------------------------------------------------------------------

;; C-x n n for narrowing / C-x n w for widening
(put 'narrow-to-defun  'disabled nil) ;; C-x n d
(put 'narrow-to-page   'disabled nil) ;; C-x n p
(put 'narrow-to-region 'disabled nil) ;; C-x n r

;; ---------------------------------------------------------------------

;; (setq vc-handled-backends (RCS CVS SVN SCCS SRC Bzr Git Hg Mtn))
;; (setq vc-handled-backends '(Git))

;; ---------------------------------------------------------------------

;; Pretty good font choices: Monospace, Inconsolata, Source Code Pro.

;; (when (eq system-type 'gnu/linux)
;;   (set-frame-font "Monospace-14"))

;; (when (eq system-type 'gnu/linux)
;;   (set-frame-font "Source Code Pro-14"))

;; (when (eq system-type 'gnu/linux)
;;   (set-face-attribute 'default nil :family "Source Code Pro")
;;   (set-face-attribute 'default nil :height 125))

(when (eq system-type 'gnu/linux)
  (set-face-attribute 'default nil :family "Inconsolata")
  (set-face-attribute 'default nil :height 140))

(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :family "Courier New")
  (set-face-attribute 'default nil :height 140))

;; ---------------------------------------------------------------------

;; ;; Open links with this week's favorite browser:
;; (setq browse-url-browser-function 'w3m-browse-url)

;; ;; Or a "custom" browser:
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "chromium")

;; ;; Use default browser in Mac OS; w3m otherwise.
;; (if (eq system-type 'darwin)
;;     (setq browse-url-browser-function 'browse-url-default-browser)
;;   (setq browse-url-browser-function 'w3m-browse-url))

(setq browse-url-browser-function 'browse-url-default-browser)

;; ---------------------------------------------------------------------

(dolist (hook '(text-mode-hook
                post-mode-hook
                message-mode-hook
                change-log-mode-hook
                log-edit-mode-hook))
  (add-hook hook (lambda()
                   (auto-fill-mode 1)
                   (flyspell-mode 1))))

;; ---------------------------------------------------------------------

;; With older versions of emacs, 'package' and 'use-package' will not
;; work.  Stop with an error in those cases.
(when (< emacs-major-version 24)
  (error "Need Emacs 24 or later; got %s" emacs-version))

;; ---------------------------------------------------------------------

(setq-default use-package-always-defer t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (eval-region (point) (point-max))))
  (load bootstrap-file nil 'nomessage))

;; Override mapping for ws-butler to correct a double-protocol typo in
;; the upstream MELPA recipe URL.
;; (https://https.git.savannah.gnu.org...) should be
;; (https://git.savannah.gnu.org...).
(setq straight-recipe-overrides
      '((nil (ws-butler
              :type git
              :repo "https://git.savannah.gnu.org/git/elpa/nongnu.git"
              :branch "elpa/ws-butler"))))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;; ---------------------------------------------------------------------

(use-package yaml-ts-mode
  :mode "\\.ya?ml\\'")

;; ---------------------------------------------------------------------

(use-package exec-path-from-shell
  :init
  (when (or (eq system-type 'darwin)
            (eq system-type 'gnu/linux))
    (exec-path-from-shell-initialize)))

;; ---------------------------------------------------------------------

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (setq ivy-count-format "(%d/%d) ")
  ;; (setq enable-recursive-minibuffers nil)
  :bind
  (:map ivy-mode-map
        ("C-'" . ivy-avy)))

(use-package counsel
  :ensure t
  :bind
  (
   ;; Ivy-based interface to standard commands.
   ("C-s"      . swiper-isearch)
   ("M-x"      . counsel-M-x)
   ("C-x C-f"  . counsel-find-file)
   ("M-y"      . counsel-yank-pop)
   ("<f1> f"   . counsel-describe-function)
   ("<f1> v"   . counsel-describe-variable)
   ("<f1> l"   . counsel-find-library)
   ("<f2> i"   . counsel-info-lookup-symbol)
   ("<f2> u"   . counsel-unicode-char)
   ("<f2> j"   . counsel-set-variable)
   ("C-x b"    . ivy-switch-buffer)
   ("C-c v"    . ivy-push-view)
   ("C-c V"    . ivy-pop-view)

   ;; Ivy-based interface to shell and system tools.
   ("C-c c"    . counsel-compile)
   ("C-c g"    . counsel-git)
   ("C-c j"    . counsel-git-grep)
   ("C-c L"    . counsel-git-log)
   ("C-c k"    . counsel-rg)
   ("C-c m"    . counsel-linux-app)
   ("C-c n"    . counsel-fzf)
   ("C-x l"    . counsel-locate)
   ("C-c J"    . counsel-file-jump)
   ("C-S-o"    . counsel-rhythmbox)
   ("C-c w"    . counsel-wmctrl)

   ;; Ivy-resume and other commands.  Ivy-resume resumes the last
   ;; Ivy-based completion.
   ("C-c C-r"  . ivy-resume)
   ("C-c b"    . counsel-bookmark)
   ("C-c d"    . counsel-descbinds)
   ("C-c g"    . counsel-git)
   ("C-c o"    . counsel-outline)
   ("C-c t"    . counsel-load-theme)
   ("C-c F"    . counsel-org-file)
   ))

;; ---------------------------------------------------------------------

;; (use-package mpg123)
;; (use-package htmlize)
;; (use-package which-func)

;; ---------------------------------------------------------------------

;; (use-package helm
;;   :bind ("M-x" . helm-M-x))

;; ---------------------------------------------------------------------

;; some utilities.

(defun insert-timestamp ()
  "Insert timestamp at point."
  (interactive)
  (insert (format-time-string "%a, %d %b %Y %H:%M:%S %z")))

(defun insert-date ()
  "Insert today's date at point."
  (interactive)
  (insert (format-time-string "%a, %d %b %Y")))

(defun insert-hhmm ()
  "Inset current hour and minute at point."
  (interactive)
  (insert (format-time-string "%I:%M%p")))

(global-set-key (kbd "<f3>")  'insert-hhmm)
(global-set-key (kbd "<f4>")  'insert-date)

;; ---------------------------------------------------------------------

(use-package window
  :straight nil
  :bind (("<f5>" . shrink-window-horizontally)
         ("<f6>" . enlarge-window-horizontally)
         ("<f7>" . shrink-window)
         ("<f8>" . enlarge-window)))

;; ---------------------------------------------------------------------

;; Switch winodws with M-[0-9] (default: C-x w [0-9])
;; winum is a possible alternative to window-number.
;; https://github.com/deb0ch/emacs-winum
(use-package winum
  :ensure t
  :init
  (setq winum-format " [ %s ]")
  :config
  (winum-mode t)
  :bind (("M-0" . winum-select-window-0-or-10)
         ("M-1" . winum-select-window-1)
         ("M-2" . winum-select-window-2)
         ("M-3" . winum-select-window-3)
         ("M-4" . winum-select-window-4)
         ("M-5" . winum-select-window-5)
         ("M-6" . winum-select-window-6)
         ("M-7" . winum-select-window-7)
         ("M-8" . winum-select-window-8)
         ("M-9" . winum-select-window-9)))

;; ---------------------------------------------------------------------

;; bring up help for key bindings
;; via http://cestlaz.github.io/posts/using-emacs-32-cpp/
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; ---------------------------------------------------------------------

;; on the fly syntax checking
;; Also via http://cestlaz.github.io/posts/using-emacs-32-cpp/
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; ---------------------------------------------------------------------

;; flycheck has been acting wonky in python-mode lately
(setq flycheck-global-modes '(not python-mode))

;; Make nicer docstrings.
(add-hook 'python-mode-hook 'python-docstring-mode)

;; (setq flymake-python-pyflakes-executable "flake8")

;; ---------------------------------------------------------------------

(use-package dockerfile-mode)
(use-package nix-mode)

;; ---------------------------------------------------------------------

(use-package recentf
  :bind ("C-c f" . recentf-open-files)
  :init
  (recentf-mode t)
  (setq recentf-save-file "~/.emacs.d/recentf"))

;; ---------------------------------------------------------------------

;; Use ssh-agent (and gpg-agent) state, when they are available,
;; instead of having to type ssh key password every time when doing a
;; magit pull/push.  Needs https://www.funtoo.org/Keychain command.
(use-package keychain-environment
  :init
  (keychain-refresh-environment))

(use-package magit
  :bind ("<f11>" . magit-status))

(use-package forge
  :after magit)

;; ---------------------------------------------------------------------

(use-package git-gutter
  :ensure t
  :init
  (when (display-graphic-p)
      (use-package git-gutter-fringe
        :ensure t))
  (global-git-gutter-mode))

;; ---------------------------------------------------------------------

;; Use ripgrep from Emacs
(use-package deadgrep
  :bind ("<f5>" . deadgrep))

;; ---------------------------------------------------------------------

;; (use-package dired-sort-menu
;;   :config
;;   (add-hook 'dired-load-hook 'dired-sort-menu))

;; ---------------------------------------------------------------------

;; This removes unsightly ^M characters that would otherwise appear in
;; the output of java applications.
(add-hook 'comint-output-filter-functions
      'comint-strip-ctrl-m)

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; ---------------------------------------------------------------------

;; via https://www.virtualbox.org/ticket/13687 -- Emacs is wonky
;; inside Virtualbox.
(add-hook 'isearch-update-post-hook 'redraw-display)

;; ---------------------------------------------------------------------

;; Rainbow mode for CSS and Yesod Shakespeare modes.
(use-package rainbow-mode
  :config
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'shakespeare-mode-hook 'rainbow-mode))

;; ---------------------------------------------------------------------

;; (setq-default show-trailing-whitespace t)
(setq-default show-trailing-whitespace nil)

;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'before-save-hook 'whitespace-cleanup)

;; Clean up whitespace, but only lines we've touched.
;; https://github.com/lewang/ws-butler
(use-package ws-butler
  :config
  (add-hook 'c-mode-hook 'ws-butler-mode)
  (add-hook 'c++-mode-hook 'ws-butler-mode)
  (add-hook 'python-mode-hook 'ws-butler-mode))

;; ---------------------------------------------------------------------

;; some fun themes: almost-monokai, monokai, solarized, zenburn, moe,
;; nano-dark.

 (use-package ample-zen-theme
   :demand t
   :config
   (load-theme 'ample-zen t))

;; ---------------------------------------------------------------------

;; Make mode line look fancy.
(use-package powerline
  :init
  (powerline-default-theme))

;; ---------------------------------------------------------------------

;; This is for situations where color-theme may not be available.

;; (setq default-frame-alist
;;       (cons
;;        '(foreground-color  . "grey60") ;; Grey
;;        default-frame-alist))
;; (setq default-frame-alist
;;       (cons
;;        '(background-color  . "black") ;; MidnightBlue / #040458
;;        default-frame-alist))
;; (setq default-frame-alist
;;       (cons
;;        '(cursor-color      . "DarkRed")
;;        default-frame-alist))

;; ---------------------------------------------------------------------

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

;; ---------------------------------------------------------------------

;; (load "~/.emacs.d/elisp/my-scheme")

;; ---------------------------------------------------------------------

(use-package tex-site
  :straight auctex
  :disabled t
  :init
  (setq-default
   TeX-auto-save t
   TeX-master nil
   TeX-parse-self t
   ;; TeX-PDF-mode t ;; To compile documents to PDF by default
   reftex-plug-into-AUCTeX t)
  :config
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (flyspell-mode)
              (LaTeX-math-mode)
              (turn-on-reftex))))

;; (use-package latex-preview-pane
;;   :init
;;   (latex-preview-pane-enable))

;; ---------------------------------------------------------------------

(use-package c-mode
  :straight nil
  :bind
  (:map c-mode-map
        ;; ("<tab>" . indent-or-complete)
        ("<ret>" . newline-and-indent)
        ("C-m"   . c-context-line-break)
        ;; Quickly switching between header and source.
        ("C-c o" . ff-find-other-file))
  :init
  (setq
   c-file-style       "linux"
   c-default-style    "linux"
   tab-width          8
   indent-tabs-mode   nil
   c-basic-offset     8)
  :config
  (which-function-mode  t)
  (c-set-style          "linux"))

(use-package c++-mode
  :straight nil
  :bind (:map c++-mode-map
              ("C-m" . c-context-line-break)))

(setq ff-search-directories
      '("." "../src" "../include"))

;; ---------------------------------------------------------------------

(load "~/.emacs.d/elisp/my-c++.el")

;; ---------------------------------------------------------------------

;; Cscope.
;; (require 'xcscope)

;; ---------------------------------------------------------------------

;; Add color to the current GUD line (obrigado google)
;; http://kousik.blogspot.com/2005/10/highlight-current-line-in-gdbemacs.html

(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face 'secondary-selection)
    ov)
  "Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
  "Highlight current line."
  (let* ((ov gud-overlay)
         (bf (gud-find-file true-file)))
    (save-excursion
      (set-buffer bf)
      (move-overlay ov (line-beginning-position) (line-end-position)
                    (current-buffer)))))

(defun gud-kill-buffer ()
  (if (eq major-mode 'gud-mode)
      (delete-overlay gud-overlay)))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)

;; ---------------------------------------------------------------------

(use-package company
  :config (global-company-mode))

;; ---------------------------------------------------------------------

(use-package yasnippet
  :init
  (yas-global-mode 1))

;; to hit tab to auto-complete (like bash does).
;; http://www.emacswiki.org/cgi-bin/wiki?EmacsNiftyTricks
;; (defun indent-or-complete ()
;;   "Complete if point is at end of a word, otherwise indent line."
;;   (interactive)
;;   (if (looking-at "\\>")
;;       (yas/expand)
;;     (indent-for-tab-command)))

;; ---------------------------------------------------------------------

;; language server

;; (use-package lsp-mode
;;   :config
;;   (add-hook 'c++-mode-hook #'lsp)
;;   (add-hook 'python-mode-hook #'lsp)
;;   (add-hook 'rust-mode-hook #'lsp)
;;   )

(use-package eglot
  :config
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'haskell-mode-hook 'eglot-ensure)
  )

;; ---------------------------------------------------------------------

(use-package dictionary
  ;; :init (setq dictionary-server "localhost")
  :config
  (if (member system-name '("nonzen.home" "idli.home"))
      (setq dictionary-server "localhost")
    (setq dictionary-server "dict.org"))
  :bind
  (("C-c D s" . dictionary-search)
   ("C-c D m" . dictionary-match-words)))

;; ---------------------------------------------------------------------

(use-package w3m
  :config (setq w3m-use-cookies t)
  :bind ("C-c g" . w3m-search))

;; ---------------------------------------------------------------------

(use-package time
  :init
  (setq display-time-24hr-format         t
        display-time-day-and-date        nil
        display-time-format              nil
        display-time-use-mail-icon       nil))

;; Diary stuff is mostly ignored -- org-journal is nicer.
(use-package calendar
  :bind ("C-c D c" . calendar)
  :init
  (setq diary-file  "~/.emacs.d/diary"
        diary-show-holidays-flag              t
        calendar-mark-holidays-flag           t
        calendar-christian-all-holidays-flag  nil
        calendar-islamic-all-holidays-flag    nil
        calendar-hebrew-all-holidays-flag     nil))

;; ---------------------------------------------------------------------

;; Add this to an .org file for sunrise/sunset:
;; * Calendar
;; %%(diary-sunrise-sunset)

(setq calendar-latitude      29.760427
      calendar-longitude     -95.369804
      calendar-location-name "Houston, TX")

;; ---------------------------------------------------------------------

;; Haskell

;; Need to have these programs: ghc-mod happy hasktags hindent hlint
;; hoogle present structured-haskell-mode stylish-haskell

;; load one of intero or regular haskell mode.
;; (load "~/.emacs.d/elisp/my-intero.el")
(load "~/.emacs.d/elisp/my-haskell.el")

;; ---------------------------------------------------------------------

;; hindent is supposed to be modern and perhaps replace
;; stylish-haskell one day.  I still like stylish-haskell...

;; (use-package hindent
;;   :init
;;   (add-hook 'haskell-mode-hook #'hindent-mode))

;; ---------------------------------------------------------------------

;; support for Yesod templates.
(use-package shakespeare-mode)

;; ---------------------------------------------------------------------

;; Org mode.

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :init
  (setq org-log-done t
        org-startup-folded t
        org-startup-indented t
        org-columns-content t
        org-align-all-tags t
        org-agenda-include-diary t)

  (setq org-default-notes-file "~/org/notes.org"
        org-archive-location   "~/org/archive.org::From %s")

  (setq org-agenda-files (list "~/org/agenda.org"
                               "~/org/sunrise.org"
                               "~/org/books.org"
                               "~/org/betty.org"
                               "~/org/chores.org"
                               "~/org/dates.org"
                               "~/org/finance.org"
                               "~/org/personal.org"
                               "~/org/projects.org"
                               "~/org/school.org"
                               "~/org/tahoe.org"
                               "~/org/work.org"
                               "~/org/research.org"
                               "~/org/jobhunt.org"))

  (setq org-todo-keywords '((sequence "TODO(t)"
                                      "FEEDBACK(f)"
                                      "VERIFY(v)"
                                      "WAITING(w!)"
                                      "|"
                                      "DONE(d)"
                                      "DELEGATED"
                                      "CANCELLED(c)")))

  :config
  (add-hook 'org-mode-hook (progn (flyspell-mode t)))) ;; end org

;; ---------------------------------------------------------------------

(require 'ox-latex)

(add-to-list 'org-latex-packages-alist '("" "minted"))

;; (setq org-latex-listings t)
(setq org-latex-listings 'minted)

;; (setq org-latex-minted-options nil)

;; (setq org-latex-minted-options '(
;;                                  ("fontsize" "\\footnotesize")
;;                                  ("frame" "lines")
;;                                  ("linenos=true")
;;                                  ))

(setq org-latex-pdf-process (list "latexmk -pdf %f"))

;; (setq org-latex-pdf-process (list "pdflatex -shell-escape %f"))

;; ---------------------------------------------------------------------

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

;; ---------------------------------------------------------------------

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  )
(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq org-latex-to-pdf-process (list "latexmk -pdf -bibtex %f"))

;; ---------------------------------------------------------------------

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa

;; ---------------------------------------------------------------------

(use-package org-clock
  :straight nil
  :init (setq org-clock-idle-time 10))

;; ---------------------------------------------------------------------

(use-package org-capture
  :straight nil
  :bind ("C-x q" . org-capture)
  :init
  (setq org-capture-templates
        '(("t"
           "Todo"
           entry
           (file+headline "~/org/capture-personal.org" "Tasks")
           "* TODO %?\n %i\n %a")
          ("j"
           "Journal"
           entry
           (file+datetree "~/org/capture-journal.org" "Journal")
           "* %U %?\n\n %i\n %a")
          ("i"
           "Idea"
           entry
           (file+datetree "~/org/capture-ideas.org" "Ideas")
           "* %^{Title}\n %i\n %a"))))

;; ---------------------------------------------------------------------

(use-package org-journal
  :ensure t
  :init
  (setq org-journal-dir "~/org/journal/"
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%A, %x"))

;; ---------------------------------------------------------------------

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/org/roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode))

;; ---------------------------------------------------------------------

;; http://jblevins.org/projects/deft/
(use-package deft
  :init
  (setq
   deft-extensions '("org" "txt" "tex")
   deft-default-extension "org"
   deft-directory "~/org/deft/"
   deft-text-mode 'org-mode)
  (global-set-key (kbd "<f9>") 'deft))

;; ---------------------------------------------------------------------

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; ---------------------------------------------------------------------

(use-package server
  :config
  (unless (server-running-p)
    (server-start)))

;; ---------------------------------------------------------------------

;; Write customizations to a separate file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; ---------------------------------------------------------------------

;; (use-package pinentry
;;   :init
;;   (pinentry-start))

(load "~/.emacs.d/elisp/my-network.el")

;; ---------------------------------------------------------------------

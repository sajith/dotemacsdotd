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

(when window-system
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (blink-cursor-mode 0))

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

;; (defvar my-backup-directory "~/.emacs.d/backups")

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
 vc-make-backup-files            nil

 ;; https://www.emacswiki.org/emacs/BackupDirectory
 backup-by-copying               t
 backup-directory-alist          '(("." . "~/.emacs.d/backups"))
 delete-old-versions             t
 kept-new-versions               6
 kept-old-versions               2
 version-control                 t
 )

;; emacs may not create backup directory?
;; (make-directory my-backup-directory t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; (setq-default show-trailing-whitespace t)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'before-save-hook 'whitespace-cleanup)

;; ---------------------------------------------------------------------

;; C-x n n for narrowing / C-x n w for widening
(put 'narrow-to-defun  'disabled nil) ;; C-x n d
(put 'narrow-to-page   'disabled nil) ;; C-x n p
(put 'narrow-to-region 'disabled nil) ;; C-x n r

;; ---------------------------------------------------------------------

;; Open links with this week's favorite browser:
(setq browse-url-browser-function 'w3m-browse-url)

;; ;; Or just use the system default browser:
;; (setq browse-url-browser-function 'browse-url-default-browser)

;; ;; Or a "custom" browser:
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "chromium")

;; ---------------------------------------------------------------------

(dolist (hook '(text-mode-hook
                post-mode-hook
                message-mode-hook
                change-log-mode-hook
                log-edit-mode-hook))
  (add-hook hook (lambda()
                   (auto-fill-mode 1)
                   (flyspell-mode 1))))

(dolist (hook '(emacs-lisp-mode-hook))
  (add-hook hook 'flyspell-mode-off))

;; ---------------------------------------------------------------------

;; With older versions of emacs, 'package' and 'use-package' will not
;; work.  Stop with an error in those cases.
(when (< emacs-major-version 24)
  (error "Need emacs 24 or later; got %s" emacs-version))

;; ---------------------------------------------------------------------

(setq-default use-package-always-defer t
              use-package-always-ensure t)

(when (>= emacs-major-version 24)
  (require 'package)
  (setq-default
   ;; Possible tls-checktrust values are: (0: Always) (1: Never) (2: Ask)
   tls-checktrust 0
   load-prefer-newer t
   package-enable-at-startup nil)
  (package-initialize)

  ;; use https sources.
  (setq package-archives
        '(("melpa" . "https://melpa.milkbox.net/packages/")
          ("gnu"   . "https://elpa.gnu.org/packages/")
          ;; ("marmalade" . "https://marmalade-repo.org/packages/")
          ))

  ;; install use-package
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  )

;; ---------------------------------------------------------------------

;; icky macOS PATH stuff.
(when (eq system-type 'darwin)
    (let* ((path-list '("/usr/local/bin"
                        "/Users/sajith/.local/bin"
                        "/Users/sajith/.cabal/bin"
                        "/Users/sajith/.nix-profile/bin"
                        "/Users/sajith/.nix-profile/sbin"
                        "/Applications/ghc-7.8.4.app/Contents/bin"))
           (path-str (mapconcat 'identity path-list path-separator)))
      (setq exec-path (append path-list exec-path))
      (setenv "PATH" (concat path-str path-separator (getenv "PATH")))))

;; ---------------------------------------------------------------------

;; ;; Some more shaved Yak hair, for eventual use

;; (defun my-load (filename)
;;   (let* ((my-path (expand-file-name "elisp" user-emacs-directory))
;;          (my-file (expand-file-name filename my-path)))
;;     (when (file-readable-p my-file)
;;       (message "Loading %s" my-file)
;;       (load my-file))))

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
  "Insert today's date at point"
  (interactive)
  (insert (format-time-string "%a, %d %b %Y")))

(defun insert-hhmm ()
  "Inset current hour and minute at point"
  (interactive)
  (insert (format-time-string "%I:%M%p")))

(global-set-key (kbd "<f3>")  'insert-hhmm)
(global-set-key (kbd "<f4>")  'insert-date)

;; ---------------------------------------------------------------------

(use-package window
  :ensure nil
  :bind (("<f5>" . shrink-window-horizontally)
         ("<f6>" . enlarge-window-horizontally)
         ("<f7>" . shrink-window)
         ("<f8>" . enlarge-window)))

;; ---------------------------------------------------------------------

(use-package window-number
  :init
  (require 'window-number)
  :config
  (window-number-mode 1)
  (window-number-meta-mode 1))

;; ---------------------------------------------------------------------

(use-package recentf
  :bind ("C-c f" . recentf-open-files)
  :init
  (recentf-mode t)
  (setq recentf-save-file "~/.emacs.d/recentf"))

;; ---------------------------------------------------------------------

(use-package magit
  :bind ("<f11>" . magit-status))

;; ---------------------------------------------------------------------

(use-package dired-sort-menu
  :config
  (add-hook 'dired-load-hook 'dired-sort-menu))

;; ---------------------------------------------------------------------

;; This removes unsightly ^M characters that would otherwise appear in
;; the output of java applications.
(add-hook 'comint-output-filter-functions
	  'comint-strip-ctrl-m)

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; ---------------------------------------------------------------------

;; Rainbow mode for CSS and Yesod Shakespeare modes.
(use-package rainbow-mode
  :config
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'shakespeare-mode-hook 'rainbow-mode))

;; ---------------------------------------------------------------------

;; other fun themes: almost-monokai and zenburn.

(use-package color-theme
  :init (color-theme-initialize))

(use-package color-theme-solarized
  :init (color-theme-solarized))

(use-package color-theme-approximate
  :init (color-theme-approximate-on))

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
  :ensure auctex
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

(use-package latex-preview-pane
  :init
  (latex-preview-pane-enable))

;; ---------------------------------------------------------------------

(use-package c-mode
  :ensure nil
  :bind
  (:map c-mode-map
        ("<tab>" . indent-or-complete)
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
  :ensure nil
  :bind (:map c++-mode-map
              ("C-m" . c-context-line-break)))

(setq ff-search-directories
      '("." "../src" "../include"))

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
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

;; to hit tab to auto-complete (like bash does).
;; http://www.emacswiki.org/cgi-bin/wiki?EmacsNiftyTricks
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (yas/expand)
    (indent-for-tab-command)))

;; ---------------------------------------------------------------------

(use-package dictionary
  ;; :init (setq dictionary-server "localhost")
  :config
  (if (member system-name '("nonzen.home" "idli.home"))
      (setq dictionary-server "localhost")
    (setq dictionary-server "dict.org"))
  :bind
  (("C-c d s" . dictionary-search)
   ("C-c d m" . dictionary-match-words)))

;; ---------------------------------------------------------------------

;; (use-package twittering-mode
;;   :config
;;   (setq
;;    twittering-use-master-password t
;;    twittering-tinyurl-service 'goo.gl)
;;   (add-hook 'twittering-edit-mode-hook
;;             (lambda()
;;               (flyspell-mode 1)
;;               (auto-fill-mode -1))))

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
  :bind ("C-c d d" . calendar)
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

(setq calendar-latitude 41.08)
(setq calendar-longitude -85.1386)
(setq calendar-location-name "Fort Wayne, IN")

;; ---------------------------------------------------------------------

;; Haskell

;; Need to have these programs: ghc-mod happy hasktags hindent hlint
;; hoogle present structured-haskell-mode stylish-haskell

;; load one of intero or regular haskell mode.
(load "~/.emacs.d/elisp/my-intero.el")
;; (load "~/.emacs.d/elisp/my-hakell.el")

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

(use-package org-clock
  :ensure nil
  :init (setq org-clock-idle-time 10))

;; ---------------------------------------------------------------------

;; (use-package org-pomodoro
;;   :config
;;   ;; (add-hook 'org-clock-in-hook 'org-pomodoro-start)
;;   (add-hook 'org-clock-out-hook 'org-pomodoro-finished)
;;   (add-hook 'org-clock-cancel-hook 'org-pomodoro-kill))

;; ---------------------------------------------------------------------

(use-package org-capture
  :ensure nil
  :bind ("C-q" . org-capture)
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

;; org+jekyll website setup.

(use-package ox-publish
  :ensure nil
  :bind (("C-x p" . org-publish-current-project)
         ("C-x f" . org-publish-current-file))
  :init
  (setq org-publish-nonzen "~/projects/nonzen.in/jekyll/")
  (setq org-publish-project-alist
        '(("nonzen-notes"
           :base-directory "~/projects/nonzen.in/org"
           :base-extension "org"
           :publishing-directory "~/projects/nonzen.in/jekyll/"
           :recursive t
           :publishing-function org-html-publish-to-html
           :htmlized-source t
           :headline-levels 4
           :auto-preamble t
           :body-only t
           :section-numbers nil
           :with-toc nil)
          ("nonzen-static"
           :base-directory "~/projects/nonzen.in/org"
           :publishing-directory "~/projects/nonzen.in/jekyll/"
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|html\\|sh\\|wma\\|ico\\|yml\\|xml\\|asc\\|txt"
           :recursive t
           :publishing-function org-publish-attachment)
          ("nonzen"
           :components ("nonzen-notes" "nonzen-static")))))

;; ---------------------------------------------------------------------

;; org journal setup.

(defvar org-journal-file "~/org/notes/journal.org"
  "Path to OrgMode journal file.")
(defvar org-journal-date-format "%Y-%m-%d"
  "Date format string for journal headings.")

(defun org-journal-entry ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (switch-to-buffer (find-file org-journal-file))
  (widen)
  (let ((today (format-time-string org-journal-date-format)))
    (beginning-of-buffer)
    ;;(unless (org-goto-local-search-forward-headings today nil t)
    (unless (org-goto-local-search-headings today nil t)
      ((lambda ()
         (org-insert-heading)
         (insert today)
         (insert "\n\n  \n"))))
    (beginning-of-buffer)
    (org-show-entry)
    (org-narrow-to-subtree)
    (end-of-buffer)
    (backward-char 2)
    (unless (= (current-column) 2)
      (insert "\n\n  "))))

;; my-org-journal.el
(global-set-key (kbd "C-c j") 'org-journal-entry)

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

(setq
 ;; Set to the location of your Org files on your local system
 org-directory "~/org"
 ;; Set to the name of the file where new notes will be stored
 org-mobile-inbox-for-pull "~/org/flagged.org"
 ;; Set to <your Dropbox root directory>/MobileOrg.
 org-mobile-directory "~/Dropbox/MobileOrg")

;; ---------------------------------------------------------------------

;; for js-comit run-js command.
;; TODO: the bindings don't run correctly; check.
(use-package js2-mode
  :config
  (setq inferior-js-program-command "/usr/bin/rhino")
  :bind
  (:map js2-mode-map
   ("C-x C-e" . js-send-last-sexp)
   ("C-M-x"   . js-send-last-sexp-and-go)
   ("C-c b"   . js-send-buffer)
   ("C-c C-b" . js-send-buffer-and-go)
   ("C-c l"   . js-load-file-and-go)))

;; ---------------------------------------------------------------------

(use-package server
  :init (server-start))

;; ---------------------------------------------------------------------

;; Write customizations to a separate file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)      
  (load custom-file))

;; ---------------------------------------------------------------------

(load "~/.emacs.d/elisp/my-network.el")

;; ---------------------------------------------------------------------

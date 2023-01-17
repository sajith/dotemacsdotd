;; ---------------------------------------------------------------------

;; Use one of these for auth stuff, depending on availability of GPG.
(load "~/.emacs.d/elisp/my-auth.el")
;; (load "~/.emacs-auth")

;; ---------------------------------------------------------------------

;; modules that depend on the above auth.

(load "~/.emacs.d/elisp/my-erc.el")
;; (load "~/.emacs.d/elisp/my-pianobar.el")
;; (load "~/.emacs.d/elisp/my-jabber.el")
;; (load "~/.emacs.d/elisp/my-smtp.el")

(load "~/.emacs.d/elisp/my-mastodon.el")

;; ---------------------------------------------------------------------

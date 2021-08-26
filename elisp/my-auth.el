
;; See auth-source.el.
;; /usr/share/emacs/xx.x/lisp/gnus/auth-source.el.gz

;; ---------------------------------------------------------------------

(require 'auth-source)

;; auth-source-pass seems to be built-in in emacs 27.
(use-package auth-source-pass)

;; ---------------------------------------------------------------------

;; https://github.com/NicolasPetton/pass
;; a major mode for editing password-store database.
;; (use-package pass)

;; ---------------------------------------------------------------------

;; (setq auth-sources '("~/.authinfo.gpg"))

;; (defun my-username (host)
;;   (nth 0 (auth-source-user-and-password host)))

;; (defun my-password (host)
;;   (nth 1 (auth-source-user-and-password host)))

;; ---------------------------------------------------------------------

(defun my-username (entry)
  (auth-source-pass-get "Username" entry))

(defun my-password (entry)
  (auth-source-pass-get 'secret entry))

;; ;; ;; ---------------------------------------------------------------------

(setq my-oftc-username (my-username "irc.oftc.net")
      my-oftc-pass  (my-password "irc.oftc.net"))

(setq my-znc-libera-username "sajith"
      my-znc-libera-pass (concat "sajith/libera:" (my-password "irc.nonzen.in/sajith")))

(setq my-znc-oftc-username "sajith"
      my-znc-oftc-pass (concat "sajith/oftc:" (my-password "irc.nonzen.in/sajith")))

;; (setq my-librefm-username (my-username "libre.fm")
;;       my-librefm-password (my-password "libre.fm"))

;; (setq my-pianobar-username (my-username "pandora.com")
;;       my-pianobar-password (my-password "pandora.com"))

;; (setq my-gtalk-jabber-password (my-password "talk.google.com"))

;; (setq my-smtp-server      "smtp.gmail.com"
;;       my-smtp-server-port 578
;;       my-smtp-username    (my-username "smtp.gmail.com")
;;       my-smtp-password    (my-password "smtp.gmail.com"))

;; ---------------------------------------------------------------------

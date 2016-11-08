
;; See auth-source.el.
;; /usr/share/emacs/xx.x/lisp/gnus/auth-source.el.gz

;; ---------------------------------------------------------------------

(require 'auth-source)

;; ---------------------------------------------------------------------

;; https://github.com/DamienCassou/auth-password-store
;; an auth-source backend for password-store.
(use-package auth-password-store
  :ensure t
  :init
  (password-store-init "0x0C6DA6A29D5F02BA")
  (auth-pass-enable))

;; ---------------------------------------------------------------------

;; (setq auth-sources '("~/.authinfo.gpg"))

;; (defun my-username (host)
;;   (nth 0 (auth-source-user-and-password host)))
  
;; (defun my-password (host)
;;   (nth 1 (auth-source-user-and-password host)))

;; ---------------------------------------------------------------------

(defun my-username (host)
  (auth-pass-get "Username" host))

(defun my-password (host)
  (password-store-get host))

;; ---------------------------------------------------------------------

(setq my-freenode-username (my-username "irc.freenode.net")
      my-freenode-pass (my-password "irc.freenode.net"))

(setq my-oftc-username (my-username "irc.oftc.net")
      my-oftc-pass  (my-password "irc.oftc.net"))

(setq my-librefm-username (my-username "libre.fm")
      my-librefm-password (my-password "libre.fm"))

(setq my-pianobar-username (my-username "pandora.com")
      my-pianobar-password (my-password "pandora.com"))

;; (setq my-gtalk-jabber-password (my-password "talk.google.com"))

;; (setq my-smtp-server      "smtp.gmail.com"
;;       my-smtp-server-port 578
;;       my-smtp-username    (my-username "smtp.gmail.com")
;;       my-smtp-password    (my-password "smtp.gmail.com"))

;; ---------------------------------------------------------------------


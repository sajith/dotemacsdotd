;; Mostly from https://www.emacswiki.org/emacs/SmtpAuth

;; ---------------------------------------------------------------------

;; (use-package smtpmail
;;   :init
;;   (setq smtpmail-debug-info           t
;;         send-mail-function            'smtpmail-send-it ;; for mail
;;         message-send-mail-function    'smtpmail-send-it ;; for message/Gnus
;;         smtpmail-smtp-server          my-smtp-server
;;         smtpmail-default-smtp-server  my-smtp-server
;;         smtpmail-smtp-service         my-smtp-server-port
;;         smtpmail-auth-credentials     '((my-smtp-server
;;                                          my-smtp-server-port
;;                                          my-smtp-username
;;                                          my-smtp-password))))

;; via https://www.emacswiki.org/emacs/GnusMSMTP
(setq message-sendmail-f-is-evil 't)
(setq message-sendmail-extra-arguments '("--read-envelope-from"))
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq sendmail-program "/usr/bin/msmtp")

;; ---------------------------------------------------------------------

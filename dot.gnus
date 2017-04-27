;; -*- mode: emacs-lisp; -*-

(setq user-full-name "Sajith Sasidharan"
      user-mail-address "sajith@hcoop.net"
      auth-sources '((:source "~/.authinfo.gpg"))
      mml-secure-openpgp-signers '("0x0C6DA6A29D5F02BA")
      mml2015-encrypt-to-self t)

(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"
      ;; gnus-agent nil
      ;; gnus-select-method '(nnnil "")
      gnus-select-method '(nntp "news.gmane.org")
      gnus-secondary-select-methods '((nnimap "imap.gmail.com")
                                      (nntp "news.gwene.org")))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(add-hook 'message-setup-hook 'mml-secure-message-encrypt)

(setq mm-decrypt-option 'known)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'ssl
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 465
      smtpmail-debug-info t
      smtpmail-debug-verb t)

;; via https://github.com/kensanata/ggg

(add-hook 'gnus-summary-mode-hook 'my-gnus-summary-keys)

(defun my-gnus-summary-keys ()
  (local-set-key "y" 'gmail-archive)
  (local-set-key "$" 'gmail-report-spam))

(defun gmail-archive ()
  "Archive the current or marked mails.
This moves them into the All Mail folder."
  (interactive)
  (gnus-summary-move-article nil "nnimap+imap.gmail.com:[Gmail]/All Mail"))

(defun gmail-report-spam ()
  "Report the current or marked mails as spam.
This moves them into the Spam folder."
  (interactive)
  (gnus-summary-move-article nil "nnimap+imap.gmail.com:[Gmail]/Spam"))

(defun gmail-trash ()
  "Move the current or marked mails to Trash folder."
  (interactive)
  (gnus-summary-move-article nil "nnimap+imap.gmail.com:[Gmail]/Trash"))

;; bbdb

(use-package bbdb
  ;; :if (display-graphic-p)
  :config
  (bbdb-initialize 'gnus 'mail 'message 'anniv)
  (bbdb-mua-auto-update-init 'gnus 'mail 'message)

  (setq bbdb-complete-mail-allow-cycling t
        bbdb-complete-name-allow-cycling t
        bbdb-allow-duplicates t
        bbdb-message-all-addresses t

        ;; or 'create to create without asking
        bbdb-mua-auto-update-p 'query

        ;; be disposable with SPC
        bbdb-electric-p t

        ;; very small
        bbdb-popup-target-lines  5)

  (add-hook 'message-setup-hook 'bbdb-mail-aliases))


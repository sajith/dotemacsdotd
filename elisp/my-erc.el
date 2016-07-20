;; erc

;; ---------------------------------------------------------------------

(use-package tls)

(use-package erc
  :init
  (setq-default
   erc-server "irc.oftc.net"
   erc-port 6667
   erc-identd-mode t
   erc-auto-set-away t
   erc-autoaway-idle-seconds 600
   erc-log-insert-log-on-open t
   erc-log-channels t
   erc-log-channels-directory "~/.irclogs/"
   erc-save-buffer-on-part t
   erc-timestamp-mode t
   erc-timestamp-format "[%R-%m/%d]"
   erc-hide-timestamps nil
   erc-track-exclude-types
   (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353"))
   erc-user-full-name user-full-name
   erc-email-userid user-mail-address     ; for when ident is not activated
   ;; erc-prompt-for-password nil         ; school irc requires a password
   erc-prompt-for-nickserv-password nil
   erc-nickserv-identify-mode 'autodetect)

  (setq erc-nickserv-passwords
        '((freenode   ((,my-freenode-username . ,my-freenode-pass)))
          (OFTC       ((,my-oftc-username     . ,my-oftc-pass)))))

  (setq erc-autojoin-channels-alist
        '(("freenode.net" "#emacs" "#haskell" "#hcoop")
          ("oftc.net"     "#debian")
          ("storjcommunity.irc.slack.com" "#dev" "#chat" "#announcements")))

  :config
  (add-hook 'erc-after-connect
            '(lambda (SERVER NICK)
               (cond
                ((string-match "freenode\\.net" SERVER)
                 (erc-message "PRIVMSG"
                              (format "NickServ identify %s" my-freenode-pass)))
                ((string-match "oftc\\.net" SERVER)
                 (erc-message "PRIVMSG"
                              (format "NickServ identify %s" my-oftc-pass))))))

  )

;; ;; Add ERC to tools menu.
;; (require 'easymenu)
;; (easy-menu-add-item nil '("tools") ["IRC" erc-select t])

;; ---------------------------------------------------------------------

;; https://www.emacswiki.org/emacs/ErcSSL
;; Or, just use erc-ssl?
(defun erc-select-ssl ()
  "Connect to IRC over SSL."
  (interactive)
  (erc-tls :server "irc.oftc.net"
           :port 6697
           :nick my-oftc-username
           :full-name user-full-name))

(defun erc-storj ()
  "Connect to storj Slack IRC gateway"
  (interactive)
  (erc-tls :server "storjcommunity.irc.slack.com"))

;; ---------------------------------------------------------------------

;; TODO: rewrite using (require)

(use-package erc-fill
  :ensure nil
  :init
  (erc-fill-mode t))

(use-package erc-ring
  :ensure nil
  :init
  (erc-ring-mode t))

(use-package erc-netsplit
  :ensure nil
  :init
  (erc-netsplit-mode t))

(use-package erc-services
  :ensure nil
  :init
  (erc-services-mode 1))

(use-package erc-join
  :ensure nil
  :config
  (erc-autojoin-mode 1))

;; ---------------------------------------------------------------------


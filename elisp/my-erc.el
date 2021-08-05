;; erc

;; ---------------------------------------------------------------------

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
   erc-prompt-for-nickserv-password nil
   erc-nickserv-identify-mode 'autodetect)
  )

;; ---------------------------------------------------------------------
;; To connect to IRC via ZNC instance

(defun erc-znc-libera ()
  "Connect to the irc.libera.chat via the bouncer."
  (interactive)
  (erc-tls :server "irc.nonzen.in"
           :port 6697
           :nick my-znc-libera-username
           :password my-znc-libera-pass
           :full-name user-full-name))

(defun erc-znc-oftc ()
  "Connect to the irc.oftc.net via the bouncer."
  (interactive)
  (erc-tls :server "irc.nonzen.in"
           :port 6697
           :nick my-znc-oftc-username
           :password my-znc-oftc-pass
           :full-name user-full-name))

;; ---------------------------------------------------------------------
;; For direct connections to IRC networks.

(defun erc-oftc ()
  "Connect to OFTC over SSL."
  (interactive)
  (erc-tls :server "irc.oftc.net"
           :port 6697
           :nick my-oftc-username
           :full-name user-full-name))

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


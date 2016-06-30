;; Mostly from http://www.emacswiki.org/JabberEl

;; ---------------------------------------------------------------------

(use-package jabber-alert
  :defer t
  :init
  (setq jabber-debug-log-xml t
        jabber-keepalive-interval 60
        jabber-debug-keep-process-buffers t
        jabber-history-enabled t
        jabber-use-global-history nil
        jabber-backlog-number 40
        jabber-backlog-days 30
        my-chat-prompt "[%t] %n>\n"
        jabber-chat-foreign-prompt-format my-chat-prompt
        jabber-chat-local-prompt-format my-chat-prompt
        jabber-groupchat-prompt-format my-chat-prompt
        jabber-muc-private-foreign-prompt-format "[%t] %g/%n>\n")

  (setq jabber-account-list
        `(("sajith@gmail.com/emacs"
           (:password        . ,my-gtalk-jabber-password))
          ("sajith@hcoop.net/emacs")))

  :config
  ;; Highlight URLs; bind C-c RET to open URLs.
  (add-hook 'jabber-chat-mode-hook 'goto-address)
  ;; Ignore presence status changes.
  (set jabber-alert-presence-message-function
       (lambda (who oldstatus newstatus statustext) nil)))

;; ---------------------------------------------------------------------

;; jabber + xosd: "osd_cat" comes from "xosd-bin" package on Debian.
(setq jabber-xosd-display-time 5)

(defun jabber-xosd-display-message (message)
  "Displays MESSAGE through the xosd"
  (let ((process-connection-type nil))
    (start-process
     "jabber-xosd"
     nil "osd_cat" "-p" "bottom" "-A" "left" "-i" "20"
     "-f" "-*-courier-*-r-*-*-30" "-c" "green" "-d"
     (number-to-string jabber-xosd-display-time))
    (process-send-string "jabber-xosd" message)
    (process-send-eof "jabber-xosd")))

(defun jabber-message-xosd (from buffer text propsed-alert)
  (jabber-xosd-display-message
   (format "%s\n%s\n%s" from buffer text)))

(add-hook 'jabber-alert-message-hooks 'jabber-message-xosd)

;; ---------------------------------------------------------------------

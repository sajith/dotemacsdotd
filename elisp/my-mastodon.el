;; https://codeberg.org/martianh/mastodon.el

;; ---------------------------------------------------------------------

(use-package mastodon
  :ensure t
  :config
  (mastodon-discover))

(setq mastodon-instance-url "https://aana.site"
      mastodon-active-user "sajith")

;; ---------------------------------------------------------------------

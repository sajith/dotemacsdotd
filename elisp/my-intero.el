;; intero stuff

;; ---------------------------------------------------------------------

;; via https://github.com/tibbe/haskell-style-guide/blob/master/haskell-style.el
(defun haskell-style-tibbe ()
  (interactive)
  (setq tab-width 4
        haskell-indentation-layout-offset 4
        haskell-indentation-left-offset 4
        haskell-indentation-ifte-offset 4
        haskell-indentation-where-pre-offset 4
        haskell-indentation-where-post-offset 4
        haskell-indentation-layout-offset 4))

;; ---------------------------------------------------------------------

(use-package intero
  :bind
  (("C-`"     . haskell-interactive-bring)
   ("C-c C-r" . haskell-process-reload-devel-main))
  :init
  (haskell-style-tibbe)
  (setq haskell-stylish-on-save t ;; needs stylish-haskell
        haskell-tags-on-save t    ;; needs hasktags
        )

  ;; These particular "setenv" lines below are a temporary hack to
  ;; work with a particular Yesod app's DevelMain.hs + the particular
  ;; static subsite of the said particular Yesod app.
  (setenv "PORT" "8000")
  (setenv "APPROOT" "http://localhost:8000")
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))

;; ---------------------------------------------------------------------

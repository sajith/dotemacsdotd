;; "setenv" lines are temporary hack to work with yesod DevelMain.
;; (setenv "PORT" "8000")
;; (setenv "APPROOT" "http://localhost:8000")

(use-package ghc)

;; structured-haskell-mode
(use-package shm)

(use-package company-ghc
  :init
  (add-to-list 'company-backends 'company-ghc)
  (custom-set-variables '(company-ghc-show-info t))
  :config
  (add-hook 'haskell-mode-hook 'company-mode))

(use-package haskell-mode
  :init
  (setq
    haskell-notify-p t
    haskell-stylish-on-save t ;; needs stylish-haskell
    haskell-tags-on-save t    ;; needs hasktags

    tab-width 4
    haskell-indent-spaces 4
    haskell-indentation-layout-offset 4
    haskell-indentation-left-offset 4
    haskell-indentation-ifte-offset 4
    haskell-indentation-where-pre-offset 4
    haskell-indentation-where-post-offset 4
    haskell-indentation-layout-offset 4

    haskell-process-log t
    haskell-process-use-ghci t
    haskell-process-type 'auto ;; options: auto/ghci/cabal-repl/stack-ghci
    haskell-compile-cabal-build-command "stack build"
    haskell-process-path-stack "/usr/bin/stack"
    ;; haskell-process-args-stack-ghci ""
    haskell-process-reload-with-fbytecode t
    haskell-process-use-presentation-mode t
    haskell-process-suggest-haskell-docs-imports t
    haskell-interactive-mode-eval-mode 'haskell-mode
    haskell-process-suggest-remove-import-lines t
    haskell-process-auto-import-loaded-modules t)

  ;; (require 'speedbar)
  ;; (speedbar-add-supported-extension ".hs")

  :config
  (add-hook 'haskell-mode-hook
            (lambda ()
              (ghc-init)
              (flycheck-mode 1) ;; annoying
              (flymake-mode 0) ;; annoying
              (interactive-haskell-mode 1)  ;; not compatible with intero
              (haskell-auto-insert-module-template)
              (turn-on-haskell-doc-mode)
              ;; (turn-on-haskell-indentation)
              (structured-haskell-mode)
              ))

  :bind
  (("C-`"     . haskell-interactive-bring))
  (:map haskell-mode-map
        ("C-c C-l" . haskell-process-load-or-reload)
        ("C-c C-r" . haskell-process-reload-devel-main)
        ("C-c C-t" . haskell-process-do-type)
        ("C-c C-i" . haskell-process-do-info)
        ("C-c C-c" . haskell-process-cabal-build)
        ("C-c C-k" . haskell-interactive-mode-clear)
        ("C-c c"   . haskell-process-cabal)

        ;; needs ghci/hasktags correctly set up.
        ("M-."     . haskell-mode-jump-to-def-or-tag)

        ("C-,"     . haskell-move-nested-left)
        ("C-."     . haskell-move-nested-right))
  ) ;; end haskell-mode


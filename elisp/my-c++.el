;; ---------------------------------------------------------------------

;; things from http://tuhdo.github.io/c-ide.html

(require 'cc-mode)
(require 'company)

(setq company-backends (delete 'company-semantic company-backends))

(define-key c-mode-map  [(tab)] 'indent-or-complete)
(define-key c++-mode-map  [(tab)] 'indent-or-complete)

;; ---------------------------------------------------------------------

(setq c-basic-offset 4)

;; ---------------------------------------------------------------------

(defun complete-or-indent ()
    (interactive)
    (if (company-manual-begin)
        (company-complete-common)
      (indent-according-to-mode)))

(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))

;; ---------------------------------------------------------------------

(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers))

;; ---------------------------------------------------------------------

(use-package semantic
  :config
  (global-semanticdb-minor-mode 1)
  (global-semantic-idle-scheduler-mode)
  (semantic-mode 1))

;; ---------------------------------------------------------------------

;; https://github.com/Sarcasm/irony-mode

(use-package irony
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode))

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; ---------------------------------------------------------------------

(use-package ggtags
  :ensure t
  :config
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
		(ggtags-mode 1)))))

;; ---------------------------------------------------------------------

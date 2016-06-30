;; Scheme stuff accumulated from B521.

;; ---------------------------------------------------------------------

(use-package quack
  :init
  (progn
    (setq quack-programs '("petite"
                           "bigloo"
                           "csi"
                           "csi -hygienic"
                           "gosh"
                           "gsi"
                           "gsi ~~/syntax-case.scm -"
                           "guile"
                           "kawa"
                           "mit-scheme"
                           "mred -z"
                           "mzscheme"
                           "mzscheme -il r6rs"
                           "mzscheme -il typed-scheme"
                           "mzscheme -M errortrace"
                           "mzscheme3m" "mzschemecgc"
                           "rs"
                           "scheme"
                           "scheme48"
                           "scsh"
                           "sisc"
                           "stklos"
                           "sxi")
          scheme-program-name "guile")
    ;; (add-hook 'scheme-mode-hook 'enable-paredit-mode))
  ))

(use-package paredit
  :disabled t)

;;; Teach Emacs how to properly indent certain Scheme special forms
;;; (such as 'pmatch')
(put 'cond 'scheme-indent-function 0)
(put 'for-each 'scheme-indent-function 0)
(put 'pmatch 'scheme-indent-function 1)
(put 'dmatch 'scheme-indent-function 1)
(put 'match 'scheme-indent-function 1)
(put 'union-case 'scheme-indent-function 2)
(put 'cases 'scheme-indent-function 1)
(put 'let-values 'scheme-indent-function 1)
(put 'call-with-values 'scheme-indent-function 2)
(put 'syntax-case 'scheme-indent-function 2)
(put 'test 'scheme-indent-function 1)
(put 'test-check 'scheme-indent-function 1)
(put 'test-divergence 'scheme-indent-function 1)
(put 'make-engine 'scheme-indent-function 0)
(put 'with-mutex 'scheme-indent-function 1)
(put 'trace-lambda 'scheme-indent-function 1)
(put 'timed-lambda 'scheme-indent-function 1)
(put 'tlambda 'scheme-indent-function 1)

;;; minikanren-specific indentation
(put 'lambdaf@ 'scheme-indent-function 1)
(put 'lambdag@ 'scheme-indent-function 1)
(put 'fresh 'scheme-indent-function 1)
(put 'exists 'scheme-indent-function 1)
(put 'exist 'scheme-indent-function 1)
(put 'nom 'scheme-indent-function 1)
(put 'run 'scheme-indent-function 2)
(put 'conde 'scheme-indent-function 0)
(put 'conda 'scheme-indent-function 0)
(put 'condu 'scheme-indent-function 0)
(put 'project 'scheme-indent-function 1)
(put 'run* 'scheme-indent-function 1)
(put 'run1 'scheme-indent-function 1)
(put 'run2 'scheme-indent-function 1)
(put 'run3 'scheme-indent-function 1)
(put 'run4 'scheme-indent-function 1)
(put 'run5 'scheme-indent-function 1)
(put 'run6 'scheme-indent-function 1)
(put 'run7 'scheme-indent-function 1)
(put 'run8 'scheme-indent-function 1)
(put 'run9 'scheme-indent-function 1)
(put 'run10 'scheme-indent-function 1)
(put 'run11 'scheme-indent-function 1)
(put 'run12 'scheme-indent-function 1)
(put 'run13 'scheme-indent-function 1)
(put 'run15 'scheme-indent-function 1)
(put 'run22 'scheme-indent-function 1)
(put 'run34 'scheme-indent-function 1)

;; ---------------------------------------------------------------------

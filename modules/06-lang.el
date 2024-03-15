;;; lang/base.el -*- lexical-binding: t -*-
;;
;; Useful settings/packages for general programming modes
;; e.g. version control, LSP, Treesitter

;; Version Control
(use-package magit)

;; Programming mode visuals
(use-package display-line-numbers
  :ensure nil
  :hook prog-mode
  :custom
  (display-line-numbers-width 2)
  (display-line-numbers-widen t))

;; Matching parens
(use-package electric-pair
  :ensure nil
  :hook prog-mode)

;; LSP - with Eglot
(use-package eglot
  :ensure nil
  :config
  ;; massive perf boost---don't log every event
  (fset #'jsonrpc--log-event #'ignore)
  ;; LSP Enabled Langs
  :hook
  ((python-ts-mode . eglot-ensure)
   (js-ts-mode . eglot-ensure)
   (java-ts-mode . eglot-ensure)))

;; Tree-sitter helper
;; Automatically installs and uses a ts major mode when available
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (add-to-list 'global-treesit-auto-modes '(not org-mode))
  (add-to-list 'global-treesit-auto-modes '(not yaml-mode))
  (global-treesit-auto-mode))


;; Expand Region with treesitter
;; TODO, but already in navigation.el

;; Linting on save with Apheleia
(use-package apheleia
  :config
  (apheleia-global-mode t)
  ;; TODO configure more, e.g. using isort, ruff etc.
  )

;; export module
(provide 'lang/base)

;;; end of lang/base.el

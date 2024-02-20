;;; lang/base.el -*- lexical-binding: t -*-
;;
;; Useful settings/packages for general programming modes
;; e.g. version control, LSP, Treesitter

;; Version Control
(use-package magit)


;; LSP - with Eglot
(use-package eglot
  :ensure nil

  :config
  ;; massive perf boost---don't log every event
  (fset #'jsonrpc--log-event #'ignore))

;; Tree-sitter helper
;; Automatically installs and uses a ts major mode when available
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (add-to-list 'global-treesit-auto-modes '(not org-mode))
  (add-to-list 'global-treesit-auto-modes '(not yaml-mode))
  (global-treesit-auto-mode))





;; export module
(provide 'lang/base)

;;; end of lang/base.el

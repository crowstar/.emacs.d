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

;; Show eldocs in a childframe
(use-package eldoc-box
  :hook
  (eglot-managed-mode . eldoc-box-hover-mode))
  
;; Tree-sitter
;; Abstract Syntax Tree based font-locking.
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

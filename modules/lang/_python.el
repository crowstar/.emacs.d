;;; lang/_python.el -*- lexical-binding: t -*-
;;
;; Python setup for treesitter/lsp
;; venv support provided by direnv, not emacs itself

;; LSP
(use-package emacs
  :ensure nil
  :hook
  (python-ts-mode . eglot-ensure))


;; export module
(provide 'lang/_python)

;;; end of lang/_python.el

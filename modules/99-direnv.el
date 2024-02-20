;;; 99-direnv.el -*- lexical-binding: t -*-
;; 
;; Per-buffer direnv activation powered by envrc.el
;; Must be executed last!

;; envrc
(use-package envrc
  :init
  (envrc-global-mode)
  (define-key envrc-mode-map (kbd "C-c d") 'envrc-command-map))


;; export module
(provide '99-direnv)

;;; end of 99-direnv.el

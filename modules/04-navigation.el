;;; 04-navigation.el -*- lexical-binding: t -*-
;;
;; Helpful packages to move around buffers!
;;

;; Avy - jump to char tree
(use-package avy
  :bind
  ("C-'" . 'avy-goto-char-timer))

;; Expand-region
;; move to Combobulate one day?
(use-package expand-region
  :bind ("C-c e" . er/expand-region))


;; export module
(provide '04-navigation)

;;; end of 04-navigation.el

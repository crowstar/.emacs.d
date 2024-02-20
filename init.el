;;; init.el -*- lexical-binding: t -*-

;; add modules path
(add-to-list 'load-path "~/.emacs.d/modules/")
(add-to-list 'load-path "~/.emacs.d/modules/lang/")

(require '01-packaging)
(require '02-base)
(require '03-completion)
(require '04-navigation)

;; programming modes
(require 'lang/base)
(require 'lang/_python)

;; goes last to ensure the hook is executed first
(require '99-direnv)
;; TODO
;; lsp (set eldoc-idle-delay lower, map bind for eglot)
;; treesitter
;; langs (python, js/jsx, web (html/css/jsx), java, etc)
;; iedit, apheleia

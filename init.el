;;; init.el -*- lexical-binding: t -*-

;; add modules path
(add-to-list 'load-path "~/.emacs.d/modules/")
(add-to-list 'load-path "~/.emacs.d/modules/lang/")

(require '01-packaging)
(require '02-base)
(require '03-completion)
(require '04-binds)

;; programming modes
(require 'lang/base)

;; TODO
;; lsp
;; treesitter
;; langs (python, web (js/ts/html/css), java, etc)

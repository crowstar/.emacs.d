;;; init.el -*- lexical-binding: t -*-

;; add modules path
(add-to-list 'load-path "~/.emacs.d/modules/")
(add-to-list 'load-path "~/.emacs.d/modules/lang/")

(require '01-packaging)
(require '02-base)
(require '03-completion)
(require '04-navigation)
(require '05-lang)

;; goes last to ensure the hook is executed first
(require '99-direnv)
;; TODO
;; bindings
;; which-key vs embark help thing
;; yes/no vs y/n

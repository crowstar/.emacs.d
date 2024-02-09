;;; early-init.el -*- lexical-binding: t -*-
;;
;; early-init.el was introduced in Emacs 27.1. It is loaded before init.el,
;; before Emacs initializes its UI or package.el, and before site files are
;; loaded. This is great place for startup optimizing, because only here can you
;; *prevent* things from loading, rather than turn them off after-the-fact.
;;

;; disable built-in package manager
(setq package-enable-at-startup nil)

;; increase garbage collection
(setq gc-cons-threshold (* 256 1024 1024))

;; annoyance suppression
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;; disable some UI
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(scroll-bar-mode -1)


;;; early-init.el ends here

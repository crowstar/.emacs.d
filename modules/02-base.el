;;; base.el -*- lexical-binding: t -*-
;;
;; customises emacs variables and base emacs functionality/defaults
;;

;; Organises various file spam into .emacs
(use-package no-littering)

;; Reconfigures annoying defaults
(use-package emacs
  :ensure nil
  :config
  ;; we don't need backup/lockfiles
  (setopt make-backup-files nil)
  (setopt create-lockfiles nil)

  ;; disable custom files
  (setopt custom-file "/dev/null")
  
  ;; Disables some warnings
  (setopt native-comp-async-report-warnings-errors nil)
  (setopt warning-suppress-log-types '((comp) (bytecomp)))

  ;; beep
  (setopt ring-bell-function 'ignore)

  ;; automatically reread from disk if file changes
  (setopt auto-revert-avoid-polling t)
  ; Some systems don't do file notifications well see https://todo.sr.ht/~ashton314/emacs-bedrock/11
  (setopt auto-revert-interval 5)
  (setopt auto-revert-check-vc-info t)
  (global-auto-revert-mode))

;; General settings
(use-package emacs
  :ensure nil
  :config
  ;; sentence defaults
  (setopt word-wrap t)
  (setopt sentence-end-double-space nil)
 
  ;; tabs
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)

  ;; Make right-click do something sensible
  (when (display-graphic-p)
    (context-menu-mode))

  ;; Mode line info
  (setopt line-number-mode t)
  (setopt column-number-mode t)

  ;; cursor
  (blink-cursor-mode -1)
  (pixel-scroll-precision-mode)

  ;; tab bar
  (setopt tab-bar-show 1))

;; Programming mode visuals
(use-package emacs
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setopt display-line-numbers-width 2)
  (setopt display-line-numbers-widen t)) ; widen when necessary

;; Theme
(use-package modus-themes
  :config
  (load-theme 'modus-vivendi-tinted t)) ; t should make it trusted

;; Set path
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))


;; export module
(provide '02-base)

;;; 02-base.el ends here

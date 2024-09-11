;;; init.el -*- lexical-binding: t -*-

;; add modules path
(add-to-list 'load-path "~/.emacs.d/modules/")

;;; Package Manager
;; sets up elpaca
;; hidden to keep tidy
(require '01-packaging)
;;; .
;;; Base
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

  ;; Some systems don't do file notifications well see https://todo.sr.ht/~ashton314/emacs-bedrock/11
  (setopt auto-revert-interval 5)
  (setopt auto-revert-check-vc-info t)

  ;; y/n instead of yes/no
  (setopt use-short-answers t)
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
  (pixel-scroll-precision-mode))

;; Theme
(use-package ef-themes
  :init
  (ef-themes-select 'ef-owl))

;; Set path
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; which key
(use-package which-key
  :config
  (which-key-mode))


;;; .
;;; Completion
;;
;; All things autocomplete/mini-buffer completion, currently powered by the MOVECC stack
;;
;; What do these packages do:
;; - Marginalia appends additional information to completion results (e.g. adds file size to find-file results)
;; - Orderless enables fuzzy-ish search
;; - Vertico renders completions (vertically as the name implies) with some additional utilities for managing history, displaying the number of results, and more
;; - Embark is a whole other thing that applies actions to completion results
;; - Corfu is the in-buffer companion of Vertico
;; - Consult is the main framework around the built-in Emacs completing-read API with default wrappers around built-in Emacs commands like finding a file, switching or killing a buffer, etc.

;; non-movec completion stuff
(use-package emacs
  :ensure nil
  :config
  ;; Add tab support for code completion.
  (setopt tab-always-indent 'complete)
  ;; recommended for vertico
  (setopt enable-recursive-minibuffers t))

;;
;; MOVEC
;;

;; Marginalia
(use-package marginalia
  :init
  (marginalia-mode))

;; Orderless
(use-package orderless
  :custom
  ;; use orderless for completion
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Vertico
(use-package vertico
  :init
  (vertico-mode)
  (setopt vertico-cycle t))

;; Persist history for vertico
(use-package savehist
  :ensure nil ; this is built-in
  :init
  (savehist-mode))

;; Embark
(use-package embark
  :bind
  (("C-." . emabrk-act)
   ("C-;" . embark-dwim)
   ("C-h B". embark-bindings))
  :config
  ;; use embark's command help menu
  (setq prefix-help-command #'embark-prefix-help-command)
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Corfu
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :init
  (global-corfu-mode))

;; Consult
;; Default config from github.com/minad/consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"
  )

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))




;;; .
;;; Navigation
;; Avy - jump to char tree
(use-package avy
  :bind
  ("C-'" . 'avy-goto-char-timer))

;; Expand-region
;; move to Combobulate one day?
(use-package expand-region
  :bind ("C-c e" . er/expand-region))


;;; .
;;; Dev / Lang specific stuff
;;
;; All programming specific setup
;; e.g. LSP, tree-sitter, lang specific modes, terminals

;; Version Control
(use-package transient)
(use-package magit
  :defer t)

(use-package forge
  :defer t
  :after magit)

;; Programming mode visuals/convenience
(use-package display-line-numbers
  :ensure nil
  :defer t
  :hook prog-mode
  :custom
  (display-line-numbers-width 2)
  (display-line-numbers-widen t))

(use-package rainbow-delimiters
  :defer t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package electric-pair
  :defer t
  :ensure nil
  :hook prog-mode)


(use-package outline-minor
  :ensure nil
  :defer t
  :hook prog-mode
  :custom
  (outline-minor-mode-cycle t))

;; LSP - with Eglot
;; (use-package eglot
;;   :defer t
;;   :ensure nil
;;   :config
;;   ;; massive perf boost---don't log every event
;;   (fset #'jsonrpc--log-event #'ignore)
;;   ;; LSP Enabled Langs
;;   :hook
;;   ((python-ts-mode . eglot-ensure)
;;    (java-ts-mode . eglot-ensure)
;;    ;; Web modes
;;    (js-ts-mode . eglot-ensure)
;;    (typescript-ts-mode . eglot-ensure)
;;    (tsx-ts-mode . eglot-ensure)))

;; LSP - with lsp-mode
(use-package lsp-mode
  :commands lsp
  :hook
  ((go-ts-mode
    python-ts-mode
    java-ts-mode
    ;; Web modes
    js-ts-mode
    typescript-ts-mode
    tsx-ts-mode) . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :custom
  (lsp-keymap-prefix "C-c l"))

(use-package lsp-ui
  :defer t)

(use-package lsp-pyright
  :defer t
  :hook
  (python-ts-mode . (lambda () (require 'lsp-pyright))))

;; Tree-sitter helper
;; Automatically installs and uses a ts major mode when available
(use-package treesit-auto
  :demand t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (add-to-list 'global-treesit-auto-modes '(not org-mode))
  (add-to-list 'global-treesit-auto-modes '(not yaml-mode))
  (global-treesit-auto-mode))


;; Manual TreeSitter mode activations
(use-package typescript-ts-mode
  :ensure nil
  :defer t
  :mode "\\.ts$")

(use-package tsx-ts-mode
  :ensure nil
  :defer t
  :mode "\\.tsx$")

;; js/ts linting
(use-package flymake-eslint
  :defer t
  :config
  ;; If Emacs is compiled with JSON support
  (setq flymake-eslint-prefer-json-diagnostics t))


;; Expand Region with treesitter
;; TODO, but already in navigation.el

;; Linting on save with Apheleia
(use-package apheleia
  :defer t
  :hook
  ((prog-mode . apheleia-mode)))

;; EAT: pure elisp terminal
(use-package eat
  :defer t
  :hook ((eshell-load . eat-eshell-mode)
         (eshell-load . eat-eshell-visual-command-mode)))

(use-package vterm
  :defer t)


;;;
;;; .
;;; direnv
;;
;; Per-buffer direnv activation powered by envrc.el
;; Must be executed last!

;; envrc
;;;
(use-package envrc
  :init
  (envrc-global-mode)
  (define-key envrc-mode-map (kbd "C-c d") 'envrc-command-map))

;;; TODO:
;; sort out # files

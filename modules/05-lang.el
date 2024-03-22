;;; 05-lang.el -*- lexical-binding: t -*-
;;
;; All programming specific setup
;; e.g. LSP, tree-sitter, lang specific modes, terminals

;; Version Control
(use-package magit)

(use-package forge
  :after magit)

;; Programming mode visuals/convenience
(use-package display-line-numbers
  :ensure nil
  :hook prog-mode
  :custom
  (display-line-numbers-width 2)
  (display-line-numbers-widen t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package electric-pair
  :ensure nil
  :hook prog-mode)

;; LSP - with Eglot
(use-package eglot
  :ensure nil
  :config
  ;; massive perf boost---don't log every event
  (fset #'jsonrpc--log-event #'ignore)
  ;; LSP Enabled Langs
  :hook
  ((python-ts-mode . eglot-ensure)
   (java-ts-mode . eglot-ensure)
   ;; Web modes
   (js-ts-mode . eglot-ensure)
   (typescript-ts-mode . eglot-ensure)
   (tsx-ts-mode . eglot-ensure)))

;; Tree-sitter helper
;; Automatically installs and uses a ts major mode when available
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (add-to-list 'global-treesit-auto-modes '(not org-mode))
  (add-to-list 'global-treesit-auto-modes '(not yaml-mode))
  (global-treesit-auto-mode))


;; Manual TreeSitter mode activations
(use-package typescript-ts-mode
  :ensure nil
  :mode "\\.ts$")

(use-package tsx-ts-mode
  :ensure nil
  :mode "\\.tsx$")

;; Expand Region with treesitter
;; TODO, but already in navigation.el

;; Linting on save with Apheleia
(use-package apheleia
  :config
  (apheleia-global-mode t)
  ;; TODO configure more, e.g. using isort, ruff etc.
  )

;; EAT: pure elisp terminal
(use-package eat
  :hook ((eshell-load . eat-eshell-mode)
         (eshell-load . eat-eshell-visual-command-mode)))


;; export module
(provide '05-lang)

;;; end of 05-lang.el

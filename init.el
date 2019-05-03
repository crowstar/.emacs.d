;; package setups
(require 'package)

;; Add package sources when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

;; Load emacs packages and activate them
;; This must come before configurations of installed packages.
;; Don't delete this line.
(package-initialize)

;; Check if use-package is installed
;; install if not
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Check if packages need updating
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; line and column nos
(add-hook 'prog-mode-hook 'linum-mode)
(setq column-number-mode t)


;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; auto-closing brackets
(electric-pair-mode 1)

;; move backup files to a specific directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;;
;; PACKAGES
;;

;; theme
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

;; which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

;; helm
(use-package helm
  :ensure t
  :init
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-candidate-number-list 50)
  :config
  (helm-mode 1)
  (require 'helm-config)
  :bind
  ("M-x" . helm-M-x)
  ("C-x b" . helm-mini)
  ("C-x C-f" . helm-find-files)
  ("<tab>" . helm-execute-persistent-action)
  ("C-z" . helm-select-action))

;; use helm for shortcuts in all modes
(use-package helm-descbinds
  :ensure t
  :bind ("C-h b" . helm-descbinds)
  :config
  (helm-descbinds-mode 1))

;; uses tramp with helm find-file
(use-package helm-tramp
  :ensure t)

(use-package helm-projectile
  :ensure t
  :bind ("C-c h" . helm-projectile))

;; projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm)
  (projectile-mode 1)
  :bind
  ("C-c p" . projectile-command-map))

;; dired stuff
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))

(use-package dired
  :config
  ;; always copy and delete recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  (require 'dired-x))

;; use exec from shell
(use-package exec-path-from-shell
 :if (memq window-system '(mac ns))
 :ensure t
 :config
 (exec-path-from-shell-copy-env "WORKON_HOME")
 (exec-path-from-shell-initialize))

;; Company. Auto-completion.
(use-package company
  :ensure t
  :bind (("C-<tab>" . company-complete))
  :config
  (global-company-mode))

;; anaconda
(use-package anaconda-mode
  :ensure t
  :commands anaconda-mode
  :config
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "-i --simple-prompt")
  :init
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

;; company-anaconda
(use-package company-anaconda
  :after (anaconda-mode company)
  :config (add-to-list 'company-backends 'company-anaconda))

;; ensures virtual env is respected
(use-package pyvenv
  :ensure t
  :commands pyvenv-mode
  :init
  (add-hook 'python-mode-hook 'pyvenv-mode))

;; syntax checking
(use-package flycheck
  :ensure t
  :config
  (setq-default flycheck-flake8-maximum-line-length 100)
  (add-hook 'prog-mode-hook 'flycheck-mode))

;; change mode-line if syntax effor
(use-package flycheck-color-mode-line
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; auto formatter (autopep8)
(use-package py-autopep8
  :ensure t
  :init
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
  (setq py-autopep8-options '("--max-line-length=100")))

;; isort for auto import sorting
(use-package py-isort
  :ensure t
  :init
  (setq py-isort-options '("--lines=100"))
  (add-hook 'before-save-hook 'py-isort-before-save))

;; Magit settings
(use-package magit
  :ensure t
  :bind ("C-x g" . 'magit-status))

;; yaml-mode
(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

;; markdown mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; dockerfile mode
(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode))

;; docker tramp
(use-package docker-tramp
  :ensure t)

;; docker
(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

;; Enable Org mode
(use-package org
  :ensure t)

;; use C-c a for agendas
(global-set-key "\C-ca" 'org-agenda)


;; emacs gui stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(docker-tramp-use-names t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (flycheck-color-mode-line py-yapf flycheck company-lsp lsp-ui lsp-mode docker docker-tramp which-key markdown-mode lv py-isort helm-projectile helm-ag dired-sidebar solarized-dark projectile auto-package-update)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

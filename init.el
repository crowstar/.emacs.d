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

(use-package undo-tree
  :init
  (undo-tree-mode))

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

(use-package helm-xref
  :ensure t
  :after helm
  :commands helm-xref
  :config
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs))

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
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(docker-tramp-use-names t)
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(inhibit-startup-screen t)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (undo-tree flycheck-color-mode-line py-yapf flycheck company-lsp lsp-ui lsp-mode docker docker-tramp which-key markdown-mode lv py-isort helm-projectile helm-ag dired-sidebar solarized-dark projectile auto-package-update)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c9485ddd1797")
     (60 . "#bf7e73b30bcb")
     (80 . "#b58900")
     (100 . "#a5a58ee30000")
     (120 . "#9d9d91910000")
     (140 . "#9595943e0000")
     (160 . "#8d8d96eb0000")
     (180 . "#859900")
     (200 . "#67119c4632dd")
     (220 . "#57d79d9d4c4c")
     (240 . "#489d9ef365ba")
     (260 . "#3963a04a7f29")
     (280 . "#2aa198")
     (300 . "#288e98cbafe2")
     (320 . "#27c19460bb87")
     (340 . "#26f38ff5c72c")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

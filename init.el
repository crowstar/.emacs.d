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

;; line nos
(add-hook 'prog-mode-hook 'linum-mode)

;; theme
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;; helm
(use-package helm
  :ensure t
  :init
  (setq helm-mode-fuzzy-match t)
  (setq helm-completion-in-region-fuzzy-match t)
  (setq helm-candidate-number-list 50))

;; projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; auto-closing brackets
(electric-pair-mode 1)

;; use python3 for interpreter
(setq python-shell-interpreter "~/Code/.virtualenvs/vector-2.7/bin/python")


;; use exec from shell
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))


;; Company. Auto-completion.
(use-package company
  :ensure t
  :bind (("C-<tab>" . company-complete))
  :config
  (global-company-mode))

;; jedi for python autocomplete
(use-package jedi
  :ensure t)

;; elpy for python IDE features
(use-package elpy
:ensure t
:config
(elpy-enable))

;; Magit settings
(use-package magit
  :bind ("C-x g" . 'magit-status)
  :ensure t)

;; yaml-mode
(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))


;;
;; ORG MODE SETTINGS
;;
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
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(elpy-rpc-python-command "python3")
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (projectile auto-package-update solarized-theme)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



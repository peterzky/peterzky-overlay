(setq custom-file "~/.emacs.d/custom.el")
(require 'package)
(package-initialize 'noactivate)
(eval-when-compile
  (require 'use-package))

(setq inhibit-startup-screen t)
(setq use-dialog-box nil)
(setq create-lockfiles nil)
(setq help-window-select t)
(setq vc-follow-symlinks "Follow link")
(setq show-paren-style 'parenthesis)
(setq Man-notify-method 'pushy)
(setq gc-cons-threshold 20000000)
(setq compilation-scroll-output t)
(setq ring-bell-function 'ignore)
(setq max-lisp-eval-depth 10000)

(line-number-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(delete-selection-mode 1)
(show-paren-mode 1)
(recentf-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq initial-scratch-message "")

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq next-screen-context-lines 2)

(use-package company
  :diminish company-mode
  :commands (company-mode global-company-mode)
  :defer 1
  :config
  (global-company-mode))

(use-package magit
  :defer
  :if (executable-find "git")
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-dispatch-popup)))

(use-package selectrum
  :config
  (selectrum-mode +1))

(use-package crux
  :diminish t
  :bind (("C-c r" . crux-rename-file-and-buffer)
	 ("C-c d" . crux-duplicate-current-line-or-region)
	 ("M-o" . crux-other-window-or-switch-buffer)
	 ("C-x 4 t" . crux-transpose-windows))
  :config
  (crux-reopen-as-root-mode))

(use-package projectile
  :commands projectile-mode
  :bind-keymap ("C-c p" . projectile-command-map)
  :defer 5
  :config
  (projectile-global-mode))

(use-package nix-mode
  :magic
  ("\.nix$" . nix-mode)
  :custom
  (nix-indent-function 'nix-indent-line))

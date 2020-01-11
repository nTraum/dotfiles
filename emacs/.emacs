(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (helm-rg fish-mode editorconfig yaml-mode helm-ag go-mode git-gutter company rubocop projectile-rails evil-args company-mode robe gruvbox-theme dashboard slim-mode helm-projectile helm evil-magit magit general flycheck linum-relative projectile evil-surround ivy which-key use-package evil evil-visual-mark-mode)))
 '(safe-local-variable-values (quote ((rubocop-autocorrect-on-save . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Display line numbers globally
;; TODO Make relative line numbers work with git gutter
(global-display-line-numbers-mode)

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

;; Fish shell syntax highlighting
(use-package fish-mode
  :ensure t
  )

;; Yaml syntax highlighting
(use-package yaml-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  )

;; editorconfig support
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Vim key bindings
(use-package evil
  :ensure t
  :config
  (evil-mode t)
)

;; Vim surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-args
  :ensure t
  :config
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
  )

;; Show key bindings
(use-package which-key :ensure t
  :init
  (which-key-mode)
)

;; Projects based on version control
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/coding/ntraum")))

(use-package gruvbox-theme
  :ensure t)

;; Startup dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t
	dashboard-startup-banner 'logo)
)

;; Syntax check
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Git in Emacs
(use-package magit
  :ensure t
  :init (add-hook 'git-commit-setup-hook 'turn-off-auto-fill
          t))

(use-package helm
  :ensure t
  :init (helm-mode 1)
  )

(use-package helm-rg
  :ensure t
  :config (setq helm-rg-default-directory 'git-root)
  )

(use-package evil-magit
  :ensure t
  )

(use-package helm-projectile
  :ensure t
  )

;; Slim template syntax
(use-package slim-mode
  :ensure t
  )

;; Auto completion framework
(use-package company
  :ensure t
  :init (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  (company-tng-configure-default)
  )

(use-package robe
  :ensure t
  :init (add-hook 'ruby-mode-hook 'robe-mode)
  (push 'company-robe company-backends)
  )

(use-package rubocop
  :ensure t
  :init (setq rubocop-autocorrect-on-save t)
)

(use-package projectile-rails
  :ensure t
  :init
  (projectile-rails-global-mode)
)

(use-package go-mode
  :ensure t
)

(use-package git-gutter
  :ensure t
  :init (global-git-gutter-mode)
)

(use-package general :ensure t
  :config
  (general-evil-setup t)
  (general-define-key
   :states '(normal)
   :prefix "SPC"
   "SPC" '(helm-M-x :which-key "execute command")
   "TAB" '(other-window :which-key "other window")
   "b"  '(:ignore t :which-key "buffers")
   "bb" '(helm-buffers-list t :which-key "helm-buffers-list")
   "d"  '(:ignore t :which-key "describe")
   "df" '(describe-function :which "function")
   "dv" '(describe-variable :which "variable")
   "dk" '(describe-key :which "key")
   "e"  '(:ignore t :which-key "emacs")
   "ee" '((lambda () (interactive)(find-file "~/.emacs")) :which-key "open .emacs")
   "er" '((lambda () (interactive)(load-file "~/.emacs")) :which-key "reload .emacs")
   "f"  '(:ignore t :which-key "files")
   "ff" '(helm-find-files :which-key "find files")
   "fg" '(helm-rg :which-key "grep files")
   "fr" '(helm-recentf :which-key "recent files")
   "g"  '(:ignore t :which-key "git")
   "gs" '(magit-status :which-key "git status")
   "p"  '(:ignore t :which-key "projectile")
   "pf" '(helm-projectile-find-file :which-key "projects find file")
   "pp" '(helm-projectile-switch-project :which-key "projects")
   "pr" '(helm-projectile-rg :which-key "projects grep")
   "r"  '(:ignore t :which-key "ruby")
   "rc" '(inf-ruby-console-auto :which-key "ruby console")
   "rd" '(robe-doc :which-key "robe doc")
   "rj" '(robe-jump :which-key "robe jump")
   "s"  '(split-window-vertically :which-key "split vertically")
   "v"  '(split-window-horizontally :which-key "split horizontally")
   "w"  '(:ignore t :which-key "window")
   "wh" '(windmove-left :which-key "move left")
   "wj" '(windmove-down :which-key "move down")
   "wk" '(windmove-up :which-key "move up")
   "wl" '(windmove-right :which-key "move right")
   )
  (general-define-key
   :states '(normal)
   "ü" '(robe-jump :which-key "robe jump")
   "Ü" '(previous-buffer :which-key "previous buffer")
  )
)

;; Disable menu and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Disable scroll bar
(scroll-bar-mode -1)

;; Show matching parentheses
(show-paren-mode 1)

;; Follow symlinks
(setq vc-follow-symlinks nil)

;; Append new line at end of file
(setq require-final-newline t)


;; Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Use tmp dir for auto saves and backup files
(setq backup-directory-alist
	`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	`((".*" ,temporary-file-directory t)))

;; Add closing tags in html-mode
(setq sgml-quick-keys 'close)

;; Start emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Mac OS specific configuration
(when (string= system-type "darwin")
  (setq mac-right-option-modifier nil
	mac-option-modifier nil
        exec-path (append exec-path '("/usr/local/bin"))
  )
)

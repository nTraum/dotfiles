;; Disable menu and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Disable scroll bar
(scroll-bar-mode -1)

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
 '(custom-safe-themes
   (quote
    ("a06658a45f043cd95549d6845454ad1c1d6e24a99271676ae56157619952394a" "123a8dabd1a0eff6e0c48a03dc6fb2c5e03ebc7062ba531543dfbce587e86f2a" default)))
 '(helm-completion-style (quote emacs))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (doom-modeline yard-mode yasnippet-snippets rspec-mode ace-jump-mode yasnippet yasipped diminish browse-at-remote haml-mode crystal-mode lsp-ui exec-path-from-shell company-lsp lsp-mode forge smartparens all-the-icons helm-rg fish-mode editorconfig yaml-mode helm-ag go-mode git-gutter company rubocop projectile-rails evil-args company-mode robe gruvbox-theme dashboard slim-mode helm-projectile helm evil-magit magit general flycheck linum-relative projectile evil-surround ivy which-key use-package evil evil-visual-mark-mode)))
 '(safe-local-variable-values
   (quote
    ((ansible-vault-password-file . "/home/ntraum/coding/vincura/ansible/vault-password.txt")
     (rubocop-autocorrect-on-save . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Display line numbers globally
;; TODO Make relative line numbers work with git gutter
(global-display-line-numbers-mode)

;; Display column number in mode line
(column-number-mode)
;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

;; Vim key bindings
(use-package evil
  :ensure t
  :config
  (evil-mode t)
)

(use-package general :ensure t
  :config
  (general-create-definer space-leader
	    :prefix "SPC"
	    :non-normal-prefix "M-SPC")
  (general-create-definer comma-leader
    :prefix ","
    :non-normal-prefix "M-,"
    )
  )

(use-package ace-jump-mode :ensure)

(use-package diminish
  :ensure
  :config
  (diminish 'auto-revert-mode)
  (diminish 'eldoc-mode)
  (diminish 'smartparens-mode)
  (diminish 'undo-tree-mode)
)

(use-package exec-path-from-shell
  :ensure t
  :init (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
  )


;; Fish shell syntax highlighting
(use-package fish-mode :ensure t)

;; Yaml syntax highlighting
(use-package yaml-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  )

;; editorconfig support
(use-package editorconfig
  :ensure t
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))


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
  :diminish
  :init
  (which-key-mode)
)

;; Projects based on version control
(use-package projectile
  :ensure t
  :diminish
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/coding/ntraum")))

(use-package gruvbox-theme :ensure t)

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
  :init
  (global-flycheck-mode)
  (setq-default flycheck-disabled-checkers '(ruby-reek))
)

;; Git in Emacs
(use-package magit
  :ensure t
  :init (add-hook 'git-commit-setup-hook 'turn-off-auto-fill
		  t)
        (setq magit-refresh-status-buffer nil)
	;; Disable showing diff in commit
	(remove-hook 'server-switch-hook 'magit-commit-diff)
  )
(use-package forge
  :ensure t
  :after magit)

(use-package browse-at-remote
  :ensure t
  :after magit)

(use-package helm
  :ensure t
  :diminish
  :init (helm-mode 1)
  )

(use-package helm-rg
  :ensure t
  :config (setq helm-rg-default-directory 'git-root)
  )

(use-package evil-magit
  :after evil magit
  :ensure t
  )

(use-package helm-projectile :ensure t)

;; Haml template syntax
(use-package haml-mode :ensure t)

;; Slim template syntax
(use-package slim-mode :ensure t)

;; Crystal language support
(use-package crystal-mode :ensure t)

;; Auto completion framework
(use-package company
  :ensure t
  :diminish company-mode
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
  :config (setq rubocop-autocorrect-on-save t)
)

(use-package rspec-mode
  :ensure t
  :general
  (comma-leader
   :states '(normal visual)
   :keymaps 'ruby-mode-map
    "tt" 'rspec-verify-single
    "tT" 'rspec-verify)
)

(use-package go-mode :ensure t)

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :init (global-git-gutter-mode)
  )

(use-package all-the-icons :ensure t)

(use-package smartparens
  :ensure t
  :init (smartparens-global-mode)
  )

(use-package lsp-mode
  :ensure t
  :hook (prog-mode . lsp))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package company-lsp
  :ensure t
  :init (push 'company-lsp company-backends))

(use-package lsp-ui :ensure)

(use-package yasnippet
  :ensure t
  :after company
  :init (yas-global-mode))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

(use-package yard-mode
  :ensure t
  :hook ruby-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(general-evil-setup t)
(space-leader
 :states '(normal visual emacs)
 :keymaps 'override
 "SPC" '(helm-M-x :which-key "execute command")
 "TAB" '(other-window :which-key "other window")

 "b"  '(:ignore t :which-key "buffers")
 "bb" '(helm-buffers-list t :which-key "helm-buffers-list")

 "c"  '(:ignore t :which-key "comment")
 "cc" '(comment-or-uncomment-region-or-line t :which-key "toggle line or region")

 "e"  '(:ignore t :which-key "emacs")
 "ee" '((lambda () (interactive)(find-file "~/.emacs")) :which-key "open .emacs")
 "er" '((lambda () (interactive)(load-file "~/.emacs")) :which-key "reload .emacs")

 "f"  '(:ignore t :which-key "files")
 "ff" '(helm-find-files :which-key "find files")
 "fg" '(helm-rg :which-key "grep files")
 "fr" '(helm-recentf :which-key "recent files")

 "g"  '(:ignore t :which-key "git")
 "gs" '(magit-status :which-key "git status")
 "gb" '(magit-branch :which-key "git branch")

 "h"  '(:ignore t :which-key "help")
 "hf" '(describe-function :which-key "function")
 "ha" '(helm-apropos :which-key "apropos")
 "hk" '(describe-key :which-key "key")
 "hm" '(describe-mode :which-key "mode")
 "hv" '(describe-variable :which-key "variable")

 "j" '(evil-ace-jump-char-mode :which-key "ace jump")

 "l"  '(:ignore t :which-key "lsp")
 "ld" '(lsp-describe-thing-at-point :which-key "describe thing")
 "ll" '(lsp-find-definition :which-key "find implementation")

 "p"  '(:ignore t :which-key "projectile")
 "pf" '(helm-projectile-find-file :which-key "projects find file")
 "pp" '(helm-projectile-switch-project :which-key "projects")
 "pr" '(helm-projectile-rg :which-key "projects grep")

 "r"  '(:ignore t :which-key "ruby")
 "rc" '(inf-ruby-console-auto :which-key "ruby console")
 "rd" '(robe-doc :which-key "robe doc")
 "rj" '(robe-jump :which-key "robe jump")
 "rb" '(ruby-toggle-block :which-key "toggle block")

 "s"  '(:ignore t :which-key "snippets")
 "ss"  '(yas-insert-snippet :which-key "search")

 "w"  '(:ignore t :which-key "window")
 "wh" '(windmove-left :which-key "move left")
 "wj" '(windmove-down :which-key "move down")
 "wk" '(windmove-up :which-key "move up")
 "wl" '(windmove-right :which-key "move right")
 )
(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 "ü" '(lsp-goto-implementation :which-key "lsp goto impl")
 "Ü" '(previous-buffer :which-key "previous buffer")
 )

(comma-leader
  :states '(normal visual)
 "t"  '(:ignore t :which-key "test")
 "f"  '(:ignore t :which-key "format")
 )


(comma-leader
  :states '(normal visual)
  :keymaps 'ruby-mode-map
  "ft" 'rubocop-autocorrect-current-file
  "fT" 'rubocop-autocorrect-current-file
  "tT" 'rspec-verify
  "tt" 'rspec-verify-single
  "tr" 'rspec-rerun
  )


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

;; Start emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Mac OS specific configuration
(when (string= system-type "darwin")
  (setq mac-right-option-modifier nil
	mac-option-modifier nil
	exec-path (append exec-path '("/usr/local/bin"))
	)
  )

					;
(defun is-lappen ()
  "Return non-nil if the host is lappen."
  (string= (system-name) "lappen"))

(defun is-bl-macbook ()
  "Return non-nil if the host is Blacklane macbook."
  (string= (system-name) "MBSOMETHING"))

(when (is-lappen)
  (set-face-attribute 'default nil
		      :family "Source Code Pro"
		      :height 120
		      )
  )

(when (is-bl-macbook)
  (set-face-attribute 'default nil :height 140)
  )


;; https://stackoverflow.com/a/9697222/1425701
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

;; Auto scroll rspec tests
(setq compilation-scroll-output t)

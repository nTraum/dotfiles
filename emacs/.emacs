;; Improve performance according to https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold 100000000) ;; 100MB
(setq read-process-output-max (* 1024 1024)) ;; 1MB

;; Disable menu and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Disable scroll bar
(scroll-bar-mode -1)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" "a06658a45f043cd95549d6845454ad1c1d6e24a99271676ae56157619952394a" "123a8dabd1a0eff6e0c48a03dc6fb2c5e03ebc7062ba531543dfbce587e86f2a" default))
 '(helm-completion-style 'emacs)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(evil-collection gnuplot-mode sudo-edit json-mode aggressive-indent elixir-mode web-mode doom-modeline yard-mode yasnippet-snippets rspec-mode ace-jump-mode yasnippet yasipped diminish browse-at-remote haml-mode crystal-mode lsp-ui exec-path-from-shell company-lsp lsp-mode forge smartparens all-the-icons helm-rg fish-mode editorconfig yaml-mode helm-ag go-mode git-gutter company rubocop projectile-rails evil-args company-mode robe gruvbox-theme dashboard slim-mode helm-projectile helm evil-magit magit general flycheck linum-relative projectile evil-surround ivy which-key use-package evil evil-visual-mark-mode))
 '(safe-local-variable-values
   '((ansible-vault-password-file . "/home/ntraum/coding/vincura/ansible/vault-password.txt")
     (rubocop-autocorrect-on-save . t))))
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
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :config (evil-collection-init)
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
(use-package elixir-mode :ensure t)

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
  (setq projectile-project-search-path '("~/coding"))
  )

(use-package gruvbox-theme :ensure t)

;; Startup dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t
        dashboard-startup-banner 'logo
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-items '((recents  . 10)
                          (projects . 10)
                          ))
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
  (setq company-minimum-prefix-length 1)
  (company-tng-mode)
  (push '(company-web-html
          company-css
          company-dabbrev-code
          company-dabbrev
          company-yasnippet
          company-files) company-backends))

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
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  (elixir-mode . lsp)
  :init
  (setq lsp-file-watch-threshold 10000)
  (add-to-list 'exec-path "/home/ntraum/bin/elixir-ls"))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

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

(use-package json-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode))
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-pairing nil)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  )

(use-package aggressive-indent
  :ensure t
  :hook web-mode
  )

(use-package sudo-edit
  :ensure t
  )

(use-package gnuplot-mode
  :ensure t
  )

(general-evil-setup t)
(space-leader
  :states '(normal visual emacs)
  :keymaps 'override
  "SPC" '(helm-M-x :which-key "execute command")
  "TAB" '(other-window :which-key "other window")

  "b"  '(:ignore t :which-key "buffers")
  "bb" '(helm-mini t :which-key "helm mini")

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
  "gb" '(magit-branch :which-key "branch")
  "gl" '(magit-log :which-key "log")
  "gs" '(magit-status :which-key "status")
  "gd" '(magit-dispatch :which-key "dispatch")
  "gf" '(magit-file-dispatch :which-key "file-dispatch")

  "h"  '(:ignore t :which-key "help")
  "hf" '(describe-function :which-key "function")
  "ha" '(helm-apropos :which-key "apropos")
  "hk" '(describe-key :which-key "key")
  "hm" '(describe-mode :which-key "mode")
  "hM" '(which-key-show-major-mode :which-key "key for major mode")
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
(setq vc-follow-symlinks t)

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
  (string= (system-name) "M20190021"))

(when (is-lappen)
  (set-face-attribute 'default nil
                      :family "JetBrains Mono"
                      :height 130
                      )
  (setq line-spacing 0.2)
  )

(load-theme 'gruvbox)

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

;; Use spaces for tabs
(setq-default indent-tabs-mode nil)

;; One tab is 2 spaces
(setq-default tab-width 2)

;; faster than default scp
(setq tramp-default-method "ssh")

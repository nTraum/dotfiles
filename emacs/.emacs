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
   '("7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "735561d82728e28f275802fc875c3a2caf14d06f434604a7516c59d49120b163"))
 '(helm-minibuffer-history-key "M-p")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(elixir-ts-mode prettier sqlite3 deadgrep rainbow-delimiters embark-consult embark inf-elixir vterm consult-lsp lsp-python-ms consult marginalia vertico tide tide-mode origami origami-mode polymode mmm-mode dumb-jump dump-jump dockerfile-mode terraform-mode evil-collection gnuplot-mode sudo-edit json-mode aggressive-indent web-mode doom-modeline yard-mode yasnippet-snippets rspec-mode ace-jump-mode yasnippet yasipped diminish browse-at-remote haml-mode crystal-mode lsp-ui exec-path-from-shell company-lsp lsp-mode forge smartparens all-the-icons helm-rg fish-mode editorconfig yaml-mode helm-ag go-mode git-gutter company rubocop projectile-rails evil-args company-mode robe gruvbox-theme dashboard slim-mode helm-projectile helm evil-magit magit general flycheck linum-relative projectile evil-surround ivy which-key use-package evil evil-visual-mark-mode))
 '(safe-local-variable-values
   '((eval prettier-mode t)
     (rspec-docker-cwd . "./")
     (rspec-use-docker-when-possible . t)
     (rspec-docker-file-name "Dockerfile")
     (rspec-docker-file-name "../docker-compose.yml")
     (rspec-docker-cwd . "/")
     (rspec-use-docker-when-possible . 1)
     (rspec-docker-container . web)
     (rubocop-autocorrect-on-save . t)
     (ansible-vault-password-file . "/home/ntraum/coding/vincura/ansible/vault-password.txt"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Start server so we can open files from the terminal in an existing emacs session
(server-start)

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
  (setq
     evil-want-keybinding nil
     evil-search-module 'evil-search)
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

;; Vertico provides a performant and minimalistic vertical completion UI based on the default completion system.
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :ensure t
  :init
  (savehist-mode))

(use-package deadgrep
  :ensure t
  :config (evil-set-initial-state 'deadgrep-mode 'emacs))

;; This package provides an orderless completion style that divides the pattern into space-separated components, and matches candidates that match all of the components in any order. Each component can match in any one of several ways: literally, as a regexp, as an initialism, in the flex style, or as multiple word prefixes. By default, regexp and literal matches are enabled.
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  ;; :bind (;; C-c bindings (mode-specific-map)
  ;;        ("C-c h" . consult-history)
  ;;        ("C-c m" . consult-mode-command)
  ;;        ("C-c k" . consult-kmacro)
  ;;        ;; C-x bindings (ctl-x-map)
  ;;        ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
  ;;        ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
  ;;        ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
  ;;        ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
  ;;        ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
  ;;        ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
  ;;        ;; Custom M-# bindings for fast register access
  ;;        ("M-#" . consult-register-load)
  ;;        ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
  ;;        ("C-M-#" . consult-register)
  ;;        ;; Other custom bindings
  ;;        ("M-y" . consult-yank-pop)                ;; orig. yank-pop
  ;;        ("<help> a" . consult-apropos)            ;; orig. apropos-command
  ;;        ;; M-g bindings (goto-map)
  ;;        ("M-g e" . consult-compile-error)
  ;;        ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
  ;;        ("M-g g" . consult-goto-line)             ;; orig. goto-line
  ;;        ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
  ;;        ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
  ;;        ("M-g m" . consult-mark)
  ;;        ("M-g k" . consult-global-mark)
  ;;        ("M-g i" . consult-imenu)
  ;;        ("M-g I" . consult-imenu-multi)
  ;;        ;; M-s bindings (search-map)
  ;;        ("M-s d" . consult-find)
  ;;        ("M-s D" . consult-locate)
  ;;        ("M-s g" . consult-grep)
  ;;        ("M-s G" . consult-git-grep)
  ;;        ("M-s r" . consult-ripgrep)
  ;;        ("M-s l" . consult-line)
  ;;        ("M-s L" . consult-line-multi)
  ;;        ("M-s m" . consult-multi-occur)
  ;;        ("M-s k" . consult-keep-lines)
  ;;        ("M-s u" . consult-focus-lines)
  ;;        ;; Isearch integration
  ;;        ("M-s e" . consult-isearch-history)
  ;;        :map isearch-mode-map
  ;;        ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
  ;;        ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
  ;;        ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
  ;;        ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
  ;;        ;; Minibuffer history
  ;;        :map minibuffer-local-map
  ;;        ("M-s" . consult-history)                 ;; orig. next-matching-history-element
  ;;        ("M-r" . consult-history))                ;; orig. previous-matching-history-element)
  )

(use-package embark
  :ensure t

  :bind
  (("C-+" . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

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

(use-package elixir-ts-mode :ensure t)

(use-package heex-ts-mode
 :ensure t)
 :init
 (add-to-list 'auto-mode-alist '("\\.heex\\'" . heex-ts-mode))

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
  :init
  ;; Disable automatic line breaking
  (add-hook 'git-commit-setup-hook 'turn-off-auto-fill t)
  ;; Enable spell correction in commit mode
  (add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell)
  ;; Disable showing diff in commit
  ;; (remove-hook 'server-switch-hook 'magit-commit-diff)
  ;; Show word diff
  (setq magit-diff-refine-hunk 'all)
  )

(use-package forge
  :ensure t
  :after magit)

(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
)

(use-package browse-at-remote
  :ensure t
  :after magit)

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
  (setq company-minimum-prefix-length 0) ;
  (setq company-selection-wrap-around t) ; continue from top when reaching bottom
  (setq company-dabbrev-downcase nil) ; do not convert to lowercase
  )
;; (push '(company-web-html
;;         company-css
;;         company-dabbrev-code
;;         company-dabbrev
;;         company-yasnippet
;;         company-files) company-backends))

(use-package robe
  :ensure t
  :init (add-hook 'ruby-mode-hook 'robe-mode)
  (push 'company-robe company-backends)
  )

(use-package rubocop
  :ensure t
  :init (add-hook 'ruby-mode-hook #'rubocop-mode)
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

(use-package inf-ruby
  :ensure t
  :init (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter))

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
  :config (setq sp-escape-quotes-after-insert nil)
  )

(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  ((elixir-ts-mode . lsp)
   (ruby-mode . lsp))
  :init
  (setq lsp-file-watch-threshold 10000
        lsp-enable-xref t
        lsp-prefer-flymake nil
        lsp-ui-doc-show-with-cursor t

        ;; https://github.com/emacs-lsp/lsp-mode/issues/3173
        ;; Not setting this breaks company completion with yasnippets
        lsp-completion-provider :none
        )
  (add-to-list 'exec-path "/home/ntraum/bin/elixir-ls-v0.16.0")
  )

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package lsp-ui :ensure)

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp))))  ; or lsp-deferred

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
  :init (doom-modeline-mode 1)
  (setq doom-modeline-vcs-max-length 32)
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         ;; (before-save . tide-format-before-save)
         ))

(use-package json-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.liquid\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mjml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode))
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-pairing nil)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  )

(use-package prettier
  :ensure t
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


(use-package terraform-mode
  :ensure t
  )

(use-package dockerfile-mode
  :ensure t
  )

;; (use-package vterm
;;   :ensure t
;;   )

(general-evil-setup t)
(space-leader
  :states '(normal visual emacs)
  :keymaps 'override
  "SPC" '(execute-extended-command :which-key "execute command")
  "TAB" '(other-window :which-key "other window")

  "b"  '(:ignore t :which-key "buffers")
  "bb" '(consult-buffer t :which-key "buffers")
  "bi" '(consult-imenu t :which-key "imenu")
  "bB" '(consult-buffer-other-window t :which-key "buffers in other window")
  "bn" '(next-buffer t :which-key "next buffer")
  "bp" '(previous-buffer t :which-key "previous buffer")

  "c"  '(:ignore t :which-key "comment")
  "cc" '(comment-or-uncomment-region-or-line t :which-key "toggle line or region")

  "e"  '(:ignore t :which-key "emacs")
  "ee" '((lambda () (interactive)(find-file "~/.emacs")) :which-key "open .emacs")
  "er" '((lambda () (interactive)(load-file "~/.emacs")) :which-key "reload .emacs")

  "f"  '(:ignore t :which-key "files")
  "ff" '(find-file :which-key "find file")
  "fd" '(dired-jump :which-key "dired")
  "fD" '(dired-jump-other-window :which-key "dired other window")
  "fg" '(helm-rg :which-key "grep files")
  "fr" '(consult-recent-file :which-key "recent files")

  "g"  '(:ignore t :which-key "git")
  "gb" '(magit-branch :which-key "branch")
  "gl" '(magit-log :which-key "log")
  "gs" '(magit-status :which-key "status")
  "gd" '(magit-dispatch :which-key "dispatch")
  "gf" '(magit-file-dispatch :which-key "file-dispatch")

  "h"  '(:ignore t :which-key "help")
  "hf" '(describe-function :which-key "function")
  "hb" '(describe-bindings :which-key "bindings")
  "ha" '(consult-apropos :which-key "apropos")
  "hk" '(describe-key :which-key "key")
  "hm" '(describe-mode :which-key "mode")
  "hM" '(which-key-show-major-mode :which-key "key for major mode")
  "hv" '(describe-variable :which-key "variable")

  "l"  '(:ignore t :which-key "lsp")
  "ld" '(lsp-describe-thing-at-point :which-key "describe thing")
  "ll" '(lsp-find-definition :which-key "find definition")
  "lr" '(lsp-find-references :which-key "find references")

  "m"  '(:ignore t :which-key "make (flycheck)")
  "mm"  '(flycheck-list-errors :which-key "list errors")
  "mn"  '(flycheck-next-error :which-key "next error")
  "mp"  '(flycheck-next-error :which-key "previous error")

  "p"  '(:ignore t :which-key "projectile")
  "pf" '(projectile-find-file :which-key "projects find file")
  "pp" '(projectile-switch-project :which-key "projects")
  "pr" '(project-find-regexp :which-key "projects grep")
  "pR" '(deadgrep :which-key "deadgrep")

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

;; Cannot be overriden
(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 "Ü" '(previous-buffer :which-key "previous buffer")
 "ü" '(evil-goto-definition :which-key "goto definition")
 )


;; Can be overriden (like magit does)
(general-define-key
 :states '(normal visual emacs)
 "s" '(evil-ace-jump-char-mode :which-key "ace jump")
 "S" '(consult-imenu :which-key "imenu")
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
  "tp" 'rspec-verify-all
  )

;; Show matching parentheses
(show-paren-mode 1)

;; Follow symlinks
(setq vc-follow-symlinks t)

;; Append new line at end of file
(setq require-final-newline t)

;; Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Use separate backup directory to prevent watchers from reloading on any input
(setq backup-directory-alist '(("." . "~/MyEmacsBackups")))

;; Use separate backup directory for auto saves
(setq auto-save-file-name-transforms
      `((".*" "~/MyEmacsBackups/autosaves" t)))

;; Disable use auto save files
(setq auto-save-default nil)

;; Disable lock files
(setq create-lockfiles nil)

;; Elixir - lsp-mode
;; Set up before-save hooks to format buffer.
(defun lsp-elixir-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t))
(add-hook 'elixir-ts-mode-hook #'lsp-elixir-install-save-hooks)

;; Start emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Mac OS specific configuration
(when (string= system-type "darwin")
  (setq mac-right-option-modifier nil
        mac-option-modifier nil
        exec-path (append exec-path '("/usr/local/bin"))
        )
  )

;; Font size
(set-face-attribute 'default nil
                    :family "Source Code Pro Medium"
                    :height 110
                    )

(defconst dark-theme 'gruvbox "My personal dark theme.")
(defconst light-theme 'gruvbox-light-medium "My personal light theme.")

(defvar current-theme light-theme "Current theme used.")
(load-theme current-theme)

(defun toggle-theme ()
  "Toggle between dark and light theme."
  (interactive)
  (if (eq current-theme dark-theme)
      (progn(load-theme light-theme)
            (setq current-theme light-theme))
    (progn(load-theme dark-theme)
          (setq current-theme dark-theme))
    )
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

;; Use spaces for tabs
(setq-default indent-tabs-mode nil)

;; One tab is displayed two spaces wide
(setq-default tab-width 2)

;; evil <, > tab width
(setq-default evil-shift-width 2)

;; Every mode has a different variable for setting tab width it seems
(setq-default js-indent-level 2)

;; Web mode tab widths
(setq-default web-mode-css-indent-offset 2)
(setq-default web-mode-code-indent-offset 2)

;; faster than default scp
(setq tramp-default-method "ssh")

(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Disable audio bell, use visual bell instead
(setq visible-bell 1)

;; Make underscore part of a word
(modify-syntax-entry ?_ "w")

;; Use shell-script mode in .env files
(add-to-list 'auto-mode-alist '("\\.env.*\\'" . shell-script-mode))

;; Use typescript-mode for tsx files
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

;; Use typescript-mode for js files because it seems to work well too
(add-to-list 'auto-mode-alist '("\\.js\\'" . typescript-mode))

;; Use ruby-mode for .xml.builder files
(add-to-list 'auto-mode-alist '("\\.xml.builder\\'" . ruby-mode))

;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

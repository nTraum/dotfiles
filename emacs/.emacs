(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

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
    (rubocop projectile-rails evil-args company-mode robe gruvbox-theme dashboard slim-mode helm-projectile helm evil-magit magit general flycheck linum-relative projectile evil-surround ivy which-key use-package evil evil-visual-mark-mode)))
 '(safe-local-variable-values (quote ((rubocop-autocorrect-on-save . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

(use-package evil
  :config
  (evil-mode t)
)

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

(use-package which-key :ensure t
  :init
  (which-key-mode)
)

(use-package linum-relative
  :ensure t
  :init (linum-relative-global-mode t)
)

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/coding/ntraum")))

(use-package gruvbox-theme
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package magit
  :ensure t
  :init (global-flycheck-mode))

(use-package helm
  :ensure t
  :init (helm-mode 1)
  )

(use-package evil-magit
  :ensure t
  )

(use-package helm-projectile
  :ensure t
  )

(use-package slim-mode
  :ensure t
  )

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

(use-package general :ensure t
  :config
  (general-evil-setup t)
  (general-define-key
   :states '(normal)
   :prefix "SPC"
   "TAB" '(other-window :which-key "other window")
   "v"   '(split-window-horizontally :which-key "split horizontally")
   "s"   '(split-window-vertically :which-key "split vertically")
   "SPC" '(helm-M-x :which-key "execute command")
   "g"  '(:ignore t :which-key "git prefix")
   "gs" '(magit-status :which-key "git status")
   "w"  '(:ignore t :which-key "window prefix")
   "wj" '(windmove-down :which-key "move down")
   "wk" '(windmove-up :which-key "move up")
   "wh" '(windmove-left :which-key "move left")
   "wl" '(windmove-right :which-key "move right")
   "p"  '(:ignore t :which-key "projectile prefix")
   "pp" '(helm-projectile :which-key "projects")
   "pf" '(helm-projectile-find-file :which-key "projects find file")
   "b"  '(:ignore t :which-key "buffers")
   "bb" '(helm-buffers-list t :which-key "helm-buffers-list")
   "r"  '(:ignore t :which-key "ruby")
   "rc" '(inf-ruby-console-auto :which-key "ruby console")
   "rj" '(robe-jump :which-key "robe jump")
   "rd" '(robe-doc :which-key "robe doc")
   )
  (general-define-key
   :states '(normal)
   "ü" '(robe-jump :which-key "robe jump")
   "Ü" '(previous-buffer :which-key "previous buffer")
  )
)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

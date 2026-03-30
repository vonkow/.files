(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Markdown
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

;; Magit
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; Ag
(unless (package-installed-p 'ag)
  (package-install 'ag))

;; Ido
;;(require 'ido)
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)

;;(unless (package-installed-p 'ido-completing-read+)
  ;;(package-install 'ido-completing-read+))
;;(ido-ubiquitous-mode 1)

;; Ivy (and Counsel and Swiper)
(unless (package-installed-p 'counsel)
  (package-install 'counsel))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "")

;;(unless (package-installed-p 'projectile)
  ;;(package-install 'projectile))

;;(setq projectile-completion-system 'ivy)
;;(projectile-mode +1)

;; Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)

;; Evil Collection (Magit, etc)
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

(when (require 'evil-collection nil t)
  (evil-collection-init))

;; Evil leader stuff
(evil-set-leader 'motion (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>SPC") 'counsel-M-x)
;;(evil-define-key 'normal 'global (kbd "<leader>SPC") 'execute-extended-command)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'counsel-switch-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bp") 'previous-buffer)
(evil-define-key 'normal 'global (kbd "<leader>dd") 'counsel-dired)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'counsel-find-file)
(evil-define-key 'normal 'global (kbd "<leader>g") 'magit)
(evil-define-key 'normal 'global (kbd "<leader>ll") 'eval-last-sexp)
(evil-define-key 'normal 'global (kbd "<leader>pb") 'project-switch-to-buffer)
(evil-define-key 'normal 'global (kbd "<leader>pf") 'project-find-file)
(evil-define-key 'normal 'global (kbd "<leader>pp") 'project-switch-project)
(evil-define-key 'normal 'global (kbd "<leader>ss") 'counsel-ag)

;; File extension mapping
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(load-theme 'tronesque t)
(tronesque-mode-line)

;; Font Tweaks
(set-frame-font "Andale Mono 15" nil t)

;; Custom
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

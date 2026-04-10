;; Packages
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)
(add-to-list 'load-path "~/.emacs.d/local-packages/")

;; Custom
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Markdown
(use-package markdown-mode)

;; Magit
(use-package magit)

;; Ag
(use-package ag)

;; Ivy (and Counsel and Swiper)
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format ""))

;; Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(require 'org)
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

;(use-package evil-org
  ;"TBD if a good idea or make your own"
  ;...see-eg-version)

;; Claude
(use-package vterm)

(use-package inheritenv
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

(use-package monet
  :vc (:url "https://github.com/stevemolitor/monet" :rev :newest))

(use-package claude-code
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config
  (add-hook
   'claude-code-process-environment-functions #'monet-start-server-function)
  (monet-mode 1)
  (claude-code-mode)
  ;:bind-keymap ("C-c c" . claude-code-command-map)
  :bind (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))
(require 'claude-code)

;; Evil leader stuff
(evil-set-leader 'motion (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>SPC") 'counsel-M-x)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'counsel-switch-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bl") 'list-buffers)
(evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bp") 'previous-buffer)
(evil-define-key 'normal 'global (kbd "<leader>c")  claude-code-command-map)
(evil-define-key 'normal 'global (kbd "<leader>dd") 'counsel-dired)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'counsel-find-file)
(evil-define-key 'normal 'global (kbd "<leader>g")  'magit)
(evil-define-key 'normal 'global (kbd "<leader>ll") 'eval-last-sexp)
(evil-define-key 'normal 'global (kbd "<leader>pb") 'project-switch-to-buffer)
(evil-define-key 'normal 'global (kbd "<leader>pf") 'project-find-file)
(evil-define-key 'normal 'global (kbd "<leader>pp") 'project-switch-project)
(evil-define-key 'normal 'global (kbd "<leader>ss") 'counsel-ag)

; Javascript!
(setq-default indent-tabs-mode nil)
(setq custom-tab-width 2)
(setq-default js-indent-level custom-tab-width)

;; File extension mapping
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))

;; Splash
(require 'splash-screen)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'tronesque t)
(tronesque-mode-line)

;; Font Tweaks
(set-frame-font "Maple Mono 15" nil t)

(use-package ligature
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  (global-ligature-mode t))

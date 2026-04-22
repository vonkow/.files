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

(require 'helpers)

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

(add-hook 'org-capture-mode-hook
          (lambda ()
            (evil-define-key 'normal 'local
              (kbd ",,") 'org-capture-finalize
              (kbd ",c") 'org-capture-finalize
              (kbd ",k") 'org-capture-kill
              (kbd ",r") 'org-capture-refile)))

(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
(setq org-default-notes-file "~/Code/todos.org")
(setq org-capture-templates
      '(("b" "Blog Post" entry (file "~/Code/blog.org")
         "* DRAFT %i %?\n:PROPERTIES:\n ::EXPORT_FILE_NAME: index\n :TITLE: \n EXPORT_HUGO_DRAFT: true\n :EXPORT_HUGO_CUSTOM_FRONT_MATTER: :subtitle \n :EXPORT_HUGO_CUSTOM_FRONT_MATTER+: :summary \n:END:\n\n"
         :prepend t
         :empty-lines 1
         :jump-to-captured t)
        ("t" "Todo" entry (file+headline "~/Code/todos.org" "TODOs")
         "*** TODO %?\n%U\n")
        ("l" "Long Term" entry (file+headline "~/Code/todos.org" "Long Term")
         "*** TODO %?\n%U\n")
        ("p" "Project" entry (file+function "~/Code/todos.org" org-capture-select-project)
         "*** TODO %?\n%U\n")
        ("n" "Note" entry (file+olp+datetree "~/Code/notes.org")
         "**** %?\n")))

;; Org-agenda evil keybindings
(with-eval-after-load 'org-agenda
  (evil-define-key 'motion org-agenda-mode-map
    ",d" 'org-agenda-deadline
    ",s" 'org-agenda-schedule
    ",p" 'org-agenda-priority))

(custom-set-variables
 '(org-agenda-files (quote ("~/Code/todos.org")))
 '(org-default-notes-file "~/Code/todos.org")
 '(org-agenda-span 7)
 '(org-agenda-start-on-weekday nil)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-agenda-custom-commands
   (quote (("A" "Priority A Focus"
            ((agenda ""
              ((org-agenda-span 7)
               (org-agenda-skip-function
                (lambda ()
                  (org-agenda-skip-entry-if 'notregexp "\\[#A\\]")))
               (org-agenda-overriding-header "Priority A Items This Week")))))
           ("P" "Priority A/B Todos"
            ((tags-todo "+PRIORITY=\"A\""
              ((org-agenda-overriding-header "Priority A Tasks:")))
             (tags-todo "+PRIORITY=\"B\""
              ((org-agenda-overriding-header "Priority B Tasks:")))))
           ("U" "Unscheduled Todos"
            ((alltodo ""
              ((org-agenda-skip-function
                (lambda ()
                  (org-agenda-skip-entry-if 'scheduled 'deadline)))
               (org-agenda-overriding-header "Unscheduled TODO entries:")))))))))

;; Org Blogging stuff
(add-to-list 'org-todo-keywords '(sequence "DRAFT(d)" "POST(p)" "|" "PUBLISH(B)"))

(use-package ox-hugo
  :ensure t
  :pin melpa
  :after ox
  :config
  (setq org-hugo-base-dir "~/Code/blog/"))

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
  (setq claude-code-terminal-backend 'vterm)
  (add-hook
   'claude-code-process-environment-functions #'monet-start-server-function)
  (monet-mode 1)
  (claude-code-mode)
  :bind (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))
(require 'claude-code)

;; Evil leader stuff
(evil-set-leader 'motion (kbd "SPC"))
(evil-define-key 'normal 'global
  (kbd "<leader>SPC") 'counsel-M-x
  (kbd "<leader>bb") 'counsel-switch-buffer
  (kbd "<leader>bl") 'list-buffers
  (kbd "<leader>bn") 'next-buffer
  (kbd "<leader>bp") 'previous-buffer
  (kbd "<leader>c")  claude-code-command-map
  (kbd "<leader>dd") 'counsel-dired
  (kbd "<leader>ff") 'counsel-find-file
  (kbd "<leader>g")  'magit
  (kbd "<leader>ll") 'eval-last-sexp
  (kbd "<leader>oa") 'org-agenda
  (kbd "<leader>oc") 'org-capture
  (kbd "<leader>pb") 'project-switch-to-buffer
  (kbd "<leader>pf") 'project-find-file
  (kbd "<leader>pp") 'project-switch-project
  (kbd "<leader>ss") 'counsel-ag
  (kbd "<leader>tt") 'vterm)

;; Org-mode evil keybindings
(with-eval-after-load 'org
  (evil-define-key 'normal org-mode-map
    ;(kbd "TAB") 'org-cycle          ; Fold/unfold headings
    ",t" 'org-todo                  ; Cycle TODO states
    ",d" 'org-deadline              ; Set deadline
    ",s" 'org-schedule              ; Schedule item
    ",p" 'org-priority              ; Set priority
    ",z" 'org-archive-subtree
    ">" 'org-shiftmetaright          ; Promote heading (** → ***)
    "<" 'org-shiftmetaleft))

(setq-default tab-width 2)

; Javascript!
(setq-default indent-tabs-mode nil)
(setq custom-tab-width 2)
(setq-default js-indent-level custom-tab-width)

;; CSS
(setq-default css-indent-offset 2)

;; File extension mapping
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))

;; Wrap text everywhere
(global-visual-line-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Splash
(require 'splash-screen)

;; Set width based on screen size, full height, and center
(let ((emacs-width
       (if (> (x-display-pixel-width) 1512) 180 120)))
  (progn
    (setq default-frame-alist
          '((left . 0.5)
            (fullscreen . fullheight)
            (user-position . t)))
    (add-to-list 'default-frame-alist (cons 'width emacs-width))))

;; Themes
(use-package base16-theme :ensure t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(let* ((themes
        '(;base16-nebula
          ;base16-material-palenight
          base16-katy
          base16-eldritch
          ;maybe base16-deep-oceanic-next
          ;base16-eris
          ; maybe base16-moonlight
          ; maybe base16-catppuccin-mocha
          tronesque
          weyland-yutani))
       (theme (random-element themes)))
  (progn (load-theme theme t)))
    ;(if (eq theme 'tronesque)
        ;(tronesque-mode-line))))

;; Font Tweaks
(set-frame-font "Maple Mono 15" nil t)

(use-package ligature
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  (ligature-set-ligatures
   'prog-mode
   '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("aae95bbe93015b723d94b7081fdb27610d393c2156e2cda2e43a1ea7624c9e6f"
     default))
 '(org-agenda-custom-commands
   '(("A" "Priority A Focus"
      ((agenda ""
               ((org-agenda-span 7)
                (org-agenda-skip-function
                 (lambda nil
                   (org-agenda-skip-entry-if 'notregexp "\\[#A\\]")))
                (org-agenda-overriding-header
                 "Priority A Items This Week")))))
     ("P" "Priority A/B Todos"
      ((tags-todo "+PRIORITY=\"A\""
                  ((org-agenda-overriding-header "Priority A Tasks:")))
       (tags-todo "+PRIORITY=\"B\""
                  ((org-agenda-overriding-header "Priority B Tasks:")))))
     ("U" "Unscheduled Todos"
      ((alltodo ""
                ((org-agenda-skip-function
                  (lambda nil
                    (org-agenda-skip-entry-if 'scheduled 'deadline)))
                 (org-agenda-overriding-header
                  "Unscheduled TODO entries:")))))))
 '(org-agenda-files '("~/Code/todos.org"))
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-span 7)
 '(org-agenda-start-on-weekday nil)
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/Code/todos.org")
 '(org-fast-tag-selection-single-key 'expert)
 '(org-reverse-note-order t)
 '(package-selected-packages
   '(ag base16-theme claude-code counsel eat evil-collection
        ido-completing-read+ ligature magit markdown-mode monet
        projectile vterm))
 '(package-vc-selected-packages
   '((claude-code :url "https://github.com/stevemolitor/claude-code.el")
     (monet :url "https://github.com/stevemolitor/monet"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

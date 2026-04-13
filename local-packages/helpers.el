;; Helper function for project capture template
(defun org-capture-select-project ()
  "Select or create a project heading under * Projects."
  (let* ((org-file (expand-file-name "~/Code/todos.org"))
         (projects (with-current-buffer (find-file-noselect org-file)
                     (goto-char (point-min))
                     (re-search-forward (concat "^\\* " "Projects" "$") nil t)
                     (condition-case nil
                       (org-map-entries
                        (lambda () (nth 4 (org-heading-components)))
                        "LEVEL=2" 'tree)
                       (error (message "Error: Malformed org file at %s" org-file)
                              nil))))
         (selection (ivy-read "Project (or type new): " projects)))
    (with-current-buffer (find-file-noselect org-file)
      (goto-char (point-min))
      (if (member selection projects)
          ;; Existing project - goto end of it
          (progn
            (re-search-forward "^\\* Projects$" nil t)
            (forward-line -1)
            (re-search-forward (concat "^\\*\\* " (regexp-quote selection) "$") nil t)
            (point))
        ;; New project - create it under * Projects
          (progn
            (if (re-search-forward "^\\* Projects$" nil t)
              (progn
                (org-end-of-subtree)
                (insert "\n** " selection "\n")
                (save-buffer)
                (forward-line -1)
                (org-end-of-subtree)
                (point))
              (error "Error: Missing '* Projects' heading in %s" org-file)))))))

(defun random-element (items)
  (let* ((size (length items))
         (index (random size)))
    (nth index items)))

(provide 'helpers)

(require 'cl-lib)

(defun splash-screen ()
  "Caz' custom splash screen"

  (interactive)
  (let* ((splash-buffer   (get-buffer-create "*splash*"))
	 (recover-session (and auto-save-list-file-prefix
			       (file-directory-p (file-name-directory
						  auto-save-list-file-prefix))))
	 (height          (- (window-body-height nil) 1))
	 (width           (window-body-width nil))
	 (padding-center  (- (/ height 2) 1))
	 (padding-bottom  (- height (/ height 2) 3)))
    (if (eq 0 (length (cl-loop for buf in (buffer-list)
			       if (buffer-file-name buf)
			       collect (buffer-file-name buf))))
	(with-current-buffer splash-buffer
	  (erase-buffer)
	  (if (one-window-p)
	      (setq mode-line-format nil))
	  (setq cursor-type nil)
	  (setq vertical-scroll-bar nil)
	  (setq horizontal-scroll-bar nil)
	  (setq fill-column width)
	  (face-remap-add-relative 'link :underline nil)
	  (insert-char ?\n padding-center)
	  (insert-text-button "Emacs "
			      'action (lambda (_) (browse-url "https://gnu.org/software/emacs/"))
			      'help-echo "Visit the emacs website"
			      'follow-link t)
	  (center-line)
	  (insert "\n")
	  (insert (concat
		   (propertize "It's GNU Emacs!" 'face 'bold)
		   " "
		   "version "
		   (format "%d.%d" emacs-major-version emacs-minor-version)))
	  (center-line)
	  (insert "\n")
	  (insert (propertize "A free/libre editor (now with more Vim)" 'face 'shadow))
	  (center-line)
	  (insert-char ?\n padding-bottom)
	  (when recover-session
	    (delete-char -2)
	    (insert-text-button "[Recover session] "
				'action (lambda (_) (call-interactively 'recover-session))
				'help-echo "Recover previous session"
				'face 'warning
				'follow-link t)
	    (center-line)
	    (insert "\n")
	    (insert "\n"))
	  (insert (propertize
		   "ABSOLUTELY NO WARRANTY, do what thou wilt." 'face 'shadow))
	  (center-line)
	  (insert "\n")
	  (insert (propertize
		   "Okay, go do now." 'face 'shadow))
	  (center-line)
	  (insert "\n")
	  (goto-char 0)
	  (read-only-mode t)
	  ;;(local-set-key [t] 'splash-screen-fade-to-scratch)
	  (local-set-key (kbd "<escape>") 'splash-screen-fade-to-scratch)
	  (local-set-key (kbd "q") 'splash-screen-fade-to-scratch)
	  (local-set-key (kbd "<mouse-1>") 'mouse-set-point)
	  (local-set-key (kbd "<mouse-2>") 'operate-this-button)
	  (display-buffer-same-window splash-buffer nil)
	  ;;(run-with-idle-timer 10.0 nil 'splash-screen-fade-to-scratch)
	  ))))

(defun splash-screen-fade-to-scratch ()
  (interactive)
  (if (get-buffer "*splash*")
      (progn 
	(scratch-buffer)
	(kill-buffer "*splash*"))))

;; Suppress any startup message in the echo area
(run-with-idle-timer 0.05 nil (lambda () (message nil)))

(if (and (not (member "--no-splash" command-line-args))
	 (not (member "--file"      command-line-args))
	 (not (member "--insert"    command-line-args))
	 (not (member "--find-file" command-line-args))
	 (not inhibit-startup-screen))
    (progn
      (add-hook 'window-setup-hook 'splash-screen)
      (setq inhibit-startup-screen t
	    inhibit-startup-message t
	    inhibit-startup-echo-area-message t)))

(provide 'splash-screen)

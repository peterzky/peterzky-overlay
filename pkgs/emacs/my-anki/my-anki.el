(require 'anki-editor)
(require 'org)
(require 'dash)
(require 'request)

(defun my:anki-build-field ()
  (let* ((element (org-element-at-point))
	 (front (org-element-property :raw-value element))
	 (contents-begin (org-element-property :contents-begin element))
	 (contents-end (org-element-property :contents-end element))
	 (skip-property (save-mark-and-excursion
			  (goto-char contents-begin)
			  (re-search-forward ":END:")
			  (point)))
	 (back (cond
		((and contents-begin contents-end)
		 (or (org-export-string-as
		      (buffer-substring
		       skip-property
		       (min (point-max) contents-end))
		      anki-editor--ox-anki-html-backend
		      t
		      anki-editor--ox-export-ext-plist)
		     ""))
		(t ""))))
    `(,(cons "Front" (format "<p>%s</p>" front)) ,(cons "Back" back))))


(defun my:anki-editor-note-at-point ()
  "Construct an alist representing a note from current entry."
  (let ((org-trust-scanner-tags t)
        (deck (org-entry-get-with-inheritance anki-editor-prop-deck))
        (note-id (org-entry-get nil anki-editor-prop-note-id))
        (note-type (org-entry-get nil anki-editor-prop-note-type))
        (tags (anki-editor--get-tags))
        (fields (my:anki-build-field)))

    (unless deck (error "No deck specified"))
    (unless note-type (error "Missing note type"))
    (unless fields (error "Missing fields"))

    `((deck . ,deck)
      (note-id . ,(string-to-number (or note-id "-1")))
      (note-type . ,note-type)
      (tags . ,tags)
      (fields . ,fields))))


(defun my:anki-editor-push-notes (&optional arg match scope)
  (interactive "P")
  (unless scope
    (setq scope (cond
                 ((region-active-p) 'region)
                 ((equal arg '(4)) 'tree)
                 ((equal arg '(16)) 'file)
                 ((equal arg '(64)) 'agenda)
                 (t nil))))

  (let* ((total (progn
                  (message "Counting notes...")
                  (length (anki-editor-map-note-entries t (or match "anki") scope))))
         (acc 0)
         (failed 0))
    (anki-editor-map-note-entries
     (lambda ()
       (message "[%d/%d] Processing notes in buffer \"%s\", wait a moment..."
                (cl-incf acc) total (buffer-name))
       (anki-editor--clear-failure-reason)
       (condition-case err
           (anki-editor--push-note (my:anki-editor-note-at-point))
         (error (cl-incf failed)
                (anki-editor--set-failure-reason (error-message-string err)))))
     match
     scope)

    (message (if (= 0 failed)
                 (format "Successfully pushed %d notes to Anki." acc)
               (format "Pushed %d notes, %d of which are failed. Check property drawers for failure reasons. Once you've fixed the issues, you could use `anki-editor-retry-failure-notes' to re-push the failed notes."
                       acc failed)))))


(defun my:ankify-entry ()
  (interactive)
  (org-set-property "ANKI_NOTE_TYPE" "Basic")
  (org-set-tags "anki"))

(provide 'my-anki)

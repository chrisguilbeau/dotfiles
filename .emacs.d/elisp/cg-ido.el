(provide 'cg-ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; ;; IDO M-x
;; (global-set-key
;;  "\M-x"
;;  (lambda ()
;;    (interactive)
;;    (call-interactively
;;     (intern
;;      (ido-completing-read
;;       "M-x "
;;       (all-completions "" obarray 'commandp))))))

;; ;; IDO Find-Tags
;; (defun my-ido-find-tag ()
;;   "Find a tag using ido"
;;   (interactive)
;;   (tags-completion-table)
;;   (let (tag-names)
;;     (mapatoms (lambda (x)
;; 		(push (prin1-to-string x t) tag-names))
;; 	      tags-completion-table)
;;     (find-tag (ido-completing-read "Tag: " tag-names))))

;; Find files in tags
(defun ido-find-file-in-tags ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Find file in tags: " (tags-table-files) nil t)))))

(defun ido-goto-symbol (&optional symbol-list)
        "Refresh imenu and jump to a place in the buffer using Ido."
	      (interactive)
	            (unless (featurep 'imenu)
		              (require 'imenu nil t))
		          (cond
			          ((not symbol-list)
				           (let ((ido-mode ido-mode)
						               (ido-enable-flex-matching
								               (if (boundp 'ido-enable-flex-matching)
										                      ido-enable-flex-matching t))
							                     name-and-pos symbol-names position)
					               (unless ido-mode
							             (ido-mode 1)
								                 (setq ido-enable-flex-matching t))
						                 (while (progn
									                     (imenu--cleanup)
											                        (setq imenu--index-alist nil)
														                   (ido-goto-symbol (imenu--make-index-alist))
																                      (setq selected-symbol
																			                             (ido-completing-read "Symbol? " symbol-names))
																		                         (string= (car imenu--rescan-item) selected-symbol)))
								           (unless (and (boundp 'mark-active) mark-active)
									                 (push-mark nil t nil))
									             (setq position (cdr (assoc selected-symbol name-and-pos)))
										               (cond
												           ((overlayp position)
													                (goto-char (overlay-start position)))
													              (t
														                   (goto-char position)))))
				         ((listp symbol-list)
					          (dolist (symbol symbol-list)
						              (let (name position)
								            (cond
									                  ((and (listp symbol) (imenu--subalist-p symbol))
											                 (ido-goto-symbol symbol))
											               ((listp symbol)
													              (setq name (car symbol))
														                    (setq position (cdr symbol)))
												                    ((stringp symbol)
														                   (setq name symbol)
																                 (setq position
																		                           (get-text-property 1 'org-imenu-marker symbol))))
									                (unless (or (null position) (null name)
												                            (string= (car imenu--rescan-item) name))
											                (add-to-list 'symbol-names name)
													              (add-to-list 'name-and-pos (cons name position))))))))
;; ;; Display ido results vertically, rather than horizontally
;; (setq ido-decorations '("\n-> " "" "\n   " "\n   ..."
;;     "[" "]" " [No match]" " [Matched]"
;;     " [Not readable]" " [Too big]" " [Confirm]"))
;; (defun ido-disable-line-trucation ()
;;     (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

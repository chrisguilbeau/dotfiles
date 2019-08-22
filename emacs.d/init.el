(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(setq package-selected-packages '(
                                  rg
                                  dumb-jump
                                  nyan-mode
                                  evil
                                  evil-leader
                                  evil-surround
                                  evil-commentary
				  fzf
				  flycheck
                                  ;; flycheck-pyflakes
                                  ))
(add-to-list 'load-path "~/.emacs.d/lisp/")

(package-install-selected-packages)
(global-flycheck-mode)
(nyan-mode)
(evil-mode)
(evil-commentary-mode)
(global-evil-surround-mode)

(setq-default
 whitespace-line-column 80
 whitespace-style       '(face lines-tail))
(add-hook 'prog-mode-hook #'whitespace-mode)
;; no trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; spaces not tabs!
(setq tab-width 4)
(setq indent-tabs-mode nil)
;; (highlight-tabs)
(setq mode-require-final-newline t) ;; newline at end of document

;; Emacs annoyances
(setq backup-inhibited t);disable backup
(setq auto-save-default nil);disable auto save
(setq large-file-warning-threshold nil) ;; no more large file warnings
(setq ring-bell-function (lambda() (message "*beep*"))) ;; don't ring bell
(line-number-mode nil)
(tool-bar-mode -1)
(menu-bar-mode 1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(setq ediff-split-window-function 'split-window-horizontally)
(setq javascript-indent-level 2)
(setq inhibit-splash-screen t) ;; don't show welcome string
(setq dabbrev-case-replace nil)

;; Emacs important things!
;; put full path of file in title
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; My functions
(defun zinit ()
  (message "Initing the z...")
  (interactive)
  (cd "c:/ZogoTech/src-proj")
  ;; (shell-command (concat "zetag"))
  ;; (visit-tags-table "/ZogoTech/src/etags")
  (evil-edit "c:/ZogoTech/src-proj")
  )

(defun edit-work-org ()
  (interactive)
  (evil-edit "~/icloud/zogotech.txt"))

(setq completion-case-ignore t)

(defun my-ido-buffer-tag-search()
  "Use ido to jump to a tag in the current buffer."
  (interactive)
  (let (
        (file-lines
         (split-string
          (shell-command-to-string
           (concat "ctags -x --python-kinds=cfmv -f- " buffer-file-name)) "\n"))
        (tbl (make-hash-table :test 'equal))
        (ido-list))
    (mapc (lambda (line)
            "Put each line in a hash table as well as ido-list."
            (let ((spl (split-string line " +")))
              (puthash (nth 0 spl) (nth 2 spl) tbl)
              (push (nth 0 spl) ido-list)
              ))
          file-lines)
    (goto-line (string-to-number(gethash
                                 (ido-completing-read "? " ido-list) tbl)))))

(defun my-ido-project-files ()
      "Use ido to select a file from the project."
      (interactive)
      ;; get project files
      (setq project-files
	    (split-string
	     (shell-command-to-string
	      (concat "rg --files --path-separator / -tpy -tjs -tcss /ZogoTech/src-proj"
		      )) "\n"))
      ;; populate hash table (display repr => path)
      (setq tbl (make-hash-table :test 'equal))
      (let (ido-list)
      (mapc (lambda (path)
	      (puthash path path tbl)
	      (push path ido-list)
	      )
	    project-files
	    )
      (find-file (gethash (ido-completing-read "project-files: " ido-list) tbl))))

(defun my-insert-week-for-org ()
  (interactive)
  (insert (concat "* Week " (shell-command-to-string "date +%V"))))

(defun zfiles ()
  (interactive)
  (start-process "zfiles" nil "zfiles.cmd")
  )

(defun zbuffertags ()
  (interactive)
  (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" "zbuffertags"
                             (buffer-file-name)))))
    (set-process-query-on-exit-flag proc nil))

(defun ztagsall ()
  (interactive)
  (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" "ztagsall"
                             ))))
    (set-process-query-on-exit-flag proc nil))

(defun edit-init-file ()
  (interactive)
  (evil-edit "~/.emacs.d/init.el"))

(defun my-ido-list-tags ()
  "list tags in current file only"
  (interactive)
  (list-tags (buffer-file-name)))

(setq ido-enable-flex-matching t) ;; allow fuzzy matches
(defun my-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapc (lambda (x)
            (unless (integerp x)
              (push (prin1-to-string x t) tag-names)))
          tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

;; fzf
'(add-to-list 'load-path "~/.fzf")
(when (memq window-system '(mac ns))
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/bin"))))

(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

(defun cg-vsplit()
  (interactive)
  (evil-window-vsplit)
  (set-80-columns)
  (evil-window-next nil)
  )

;; replace current word or selection using vim style for evil mode
(defun query-replace-word-under-cursor()
  (interactive)
  (if (use-region-p)
      (let (
	    (selection
	     (buffer-substring-no-properties (region-beginning) (region-end))))
	(if (= (length selection) 0)
	    (message "empty string")
	  (evil-ex (concat "'<,'>s/" selection "/"))
	  ))
    (evil-ex (concat "%s/" (thing-at-point 'word) "/"))))

;; Evil Leader Keybindings!!!
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'my-ido-project-files
  "b" 'my-ido-buffer-tag-search
  "k" 'ibuffer
  "f" 'evilem-motion-find-char
  "t" 'helm-etags-select
  "zz" 'zinit
  "i" 'edit-init-file
  "o" 'edit-work-org
  "=" 'set-80-columns
  "n" 'linum-mode
  "v" 'cg-vsplit
  "hg" 'vc-ediff
  "zc" 'vc-dir
  "r" 'query-replace-word-under-cursor
  "g]" 'rg-forward-history
  "g[" 'rg-back-history
  "w" 'my-insert-week-for-org
  )

;; Python things
(require 'python)

(defun my-shell-mode-hook ()
  (add-hook 'comint-output-filter-functions 'python-pdbtrack-comint-output-filter-function t))

(add-hook 'shell-mode-hook 'my-shell-mode-hook)

;; Start the server
;; (server-start)

;; tagging things
(define-key evil-normal-state-map (kbd "C-]")
  (lambda () (interactive) (dumb-jump-go)))

(define-key evil-normal-state-map (kbd "]]") 'pop-tag-mark)

(define-key evil-normal-state-map (kbd "]t")
  (lambda () (interactive) (find-tag last-tag t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (find-file-in-project ffip rg dumb-jump nyan-mode evil flymake-python-pyflakes evil-leader evil-surround evil-commentary monokai-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

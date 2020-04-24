;; emacs configure
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
(which-func-mode 1) ;; show current function and class

;; python stuff
(setenv "PYTHONUNBUFFERED" "1")

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
;; (setq inhibit-splash-screen t) ;; don't show welcome string
(setq dabbrev-case-replace nil)

;; Emacs important things!
;; put full path of file in title
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; list packages you need here
(setq package-selected-packages '(
				  dumb-jump
				  evil
				  evil-commentary
				  evil-leader
				  evil-surround
				  nyan-mode
				  ztree
				  rg
				  ))
(package-initialize)
(package-refresh-contents)
(package-install-selected-packages)

;; evil

;; rg
(setq grep-find-command
 '((concat "rg -n -H --no-heading -e '' " my-project-root) . 27)
 )
(setq rg-command-line-flags '(
                              "--follow"
                              ))

;; ztree
(setq ztree-diff-filter-list '(
                               "^.*\\.pyc"
                               ))

;; dumb jump

;; nyan-mode
(nyan-mode)

;; evil
(evil-mode)
(evil-commentary-mode)
(global-evil-surround-mode)
(global-evil-leader-mode)
(eval-after-load "vc-hooks"
  '(define-key vc-prefix-map "=" 'vc-ediff))

(defun evil-edit-init-file ()
  (interactive)
  (evil-edit "~/.emacs.d/init.el"))

(defun evil-vsplit ()
  (interactive)
  (evil-window-vsplit)
  (evil-set-80-columns)
  (evil-window-next nil))

(defun evil-query-replace-word-under-cursor()
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

(defun evil-set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

(define-key evil-normal-state-map (kbd "C-]")
  (lambda () (interactive) (dumb-jump-go)))

(define-key evil-normal-state-map (kbd "]]") 'pop-tag-mark)

(define-key evil-normal-state-map (kbd "]t")
  (lambda () (interactive) (find-tag last-tag t)))


(evil-leader/set-key
  "e" 'my-ido-project-files
  "b" 'my-ido-buffer-tag-search
  "k" 'ibuffer
  "f" 'evilem-motion-find-char
  "t" 'my-project-tag-search
  "zz" 'zinit
  "i" 'evil-edit-init-file
  "o" 'edit-work-org
  "=" 'evil-set-80-columns
  "n" 'linum-mode
  "v" 'evil-vsplit
  "hg" 'vc-ediff
  "zc" 'vc-dir
  "r" 'evil-query-replace-word-under-cursor
  "g]" 'rg-forward-history
  "g[" 'rg-back-history
  "w" 'my-insert-week-for-org
  )

;; my-proj
(setq my-project-root (getenv "pwd"))
(setq my-project-types "")
(setq my-ctags-bin "ctags.exe")
(setq my-project-folders ".")
(setq my-ctags-excludes " ")
(setq my-ctags-languages " ")
(setq my-ctags-kinds " ")

(defun zinit ()
  (interactive)
  (setq my-project-root "/ZogoTech/src/")
  (setq my-project-types " -tpy -tjs -tcss -ttxt")
  (setq my-ctags-excludes "--exclude=.hg --exclude=*.min.js --exclude=3p")
  (setq my-ctags-languages "--languages=Python,Javascript")
  (setq my-ctags-kinds "--python-kinds=cfmvl")
  (setq my-project-folders "server webserver appserver")
  (evil-edit my-project-root)
  )

(defun my-project-tag-search()
  "Use ido to jump to a tag in the current project."
  (interactive)
  (let (
        (file-lines
         (split-string
          (shell-command-to-string
           (concat my-ctags-bin
                   " -R -x -f- "  ;; recursive to standard output, no file
                   my-ctags-excludes " "
                   my-ctags-languages " "
                   my-ctags-kinds " "
                   my-project-folders
                   )) "\n"))
        (tbl (make-hash-table :test 'equal))
        (ido-list))
    (mapc (lambda (line)
            "Put each line in a hash table as well as ido-list."
            (let ((spl (split-string line " +")))
              (puthash (nth 0 spl)
                       (concat "[["
			       my-project-root
			       "/"
                               (nth 3 spl)
                               "::"
                               (nth 2 spl)
                               "]]"
                               )
                       tbl)
              (push
               (nth 0 spl)
               ido-list)
              ))
          file-lines)
    (org-open-link-from-string (gethash (ido-completing-read "? " ido-list) tbl))))

(defun my-ido-buffer-tag-search()
  "Use ido to jump to a tag in the current buffer."
  (interactive)
  (let (
        (file-lines
         (split-string
          (shell-command-to-string
           (concat my-ctags-bin " -x --python-kinds=cfmv -f- " buffer-file-name)) "\n"))
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
	      (concat "(cd "
                  my-project-root " && "
                  "rg --follow --files --path-separator / "
                  my-project-types " "
		  my-project-folders " "
                  " )"
		      )) "\n"))
      ;; populate hash table (display repr => path)
      (setq tbl (make-hash-table :test 'equal))
      (let (ido-list)
        (mapc (lambda (path)
	      (puthash path (concat my-project-root path) tbl)
	      (push path ido-list)
	      )
	    project-files
	    )
      (find-file (gethash (ido-completing-read "project-files: " ido-list) tbl))))

(custom-set-variables
(custom-set-faces
 '(default ((t (:family "Cascadia Code" :foundry "outline" :slant normal :weight normal :height 98 :width normal))))))

;; Turn off some things
(tool-bar-mode 0)
(menu-bar-mode 0)
(toggle-scroll-bar -1) 
(setq inhibit-startup-message t)

;; make font bigger
(set-face-attribute 'default nil :height 140)

;; configure backups
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; orgmode stuff
(setq org-todo-keywords '((type "NOW" "|" "DONE" "DUD")))

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; set locate to use mdfind
(setq locate-command "mdfind")

;; list the repositories containing them
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; highlight long lines
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; ido stuff
(defun ido-file-in-tags ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t)) (visit-tags-table-buffer))
    (find-file (expand-file-name
                (ido-completing-read "File in tags: "
                                     (tags-table-files) nil t)))))

(defun my-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (visit-tags-table-buffer)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
		(push (prin1-to-string x t) tag-names))
	      tags-completion-table)
          (find-tag (ido-completing-read "Tag: " tag-names))))

;; better find files
(defun files-in-below-directory (directory)
       "List the .el files in DIRECTORY and in its sub-directories."
       ;; Although the function will be used non-interactively,
       ;; it will be easier to test if we make it interactive.
       ;; The directory will have a name such as
       ;;  "/usr/local/share/emacs/22.1.1/lisp/"
       (interactive "DDirectory name: ")
       (let (el-files-list
             (current-directory-list
              (directory-files-and-attributes directory t)))
         ;; while we are in the current directory
         (while current-directory-list
           (cond
            ;; check to see whether filename ends in `.el'
            ;; and if so, append its name to a list.
            ((equal ".py" (substring (car (car current-directory-list)) -3))
             (setq el-files-list
                   (cons (car (car current-directory-list)) el-files-list)))
            ;; check whether filename is that of a directory
            ((eq t (car (cdr (car current-directory-list))))
             ;; decide whether to skip or recurse
             (if
                 (equal "."
                        (substring (car (car current-directory-list)) -1))
                 ;; then do nothing since filename is that of
                 ;;   current directory or parent, "." or ".."
                 ()
               ;; else descend into the directory and repeat the process
               (setq el-files-list
                     (append
                      (files-in-below-directory
                       (car (car current-directory-list)))
                      el-files-list)))))
           ;; move to the next filename in the list; this also
           ;; shortens the list so the while loop eventually comes to an end
           (setq current-directory-list (cdr current-directory-list)))
         ;; return the filenames
         el-files-list))

;; Find files in dir
(defun ido-find-files-in-dir ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t)) (visit-tags-table-buffer))
    (find-file (expand-file-name
                (ido-completing-read "File in tags: "
                                     (files-in-below-directory (substring (pwd) 10)) nil t)))))


;; package stuff
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; list the packages you want
(defvar package-list
  '(
    etags-select
    edit-server
    evil
    evil-leader
    multiple-cursors
    yasnippet
    etags-select
    auto-complete-etags
    python-mode
    solarized-theme
    nyan-mode
    ;; latex-preview-pane
    ;; helm
    ))

(require 'cl)

;; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in package-list
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; install missing packages
(unless (packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p package-list)
    (when (not (package-installed-p p))
      (package-install p))))

(defun ido-find-file-in-tag-files ()
      (interactive)
      (save-excursion
        (let ((enable-recursive-minibuffers t))
          (visit-tags-table-buffer))
        (find-file
         (expand-file-name
          (ido-completing-read
           "File in tags: " (tags-table-files) nil t)))))

;; turn on and configure packages
(require 'edit-server)
(edit-server-start)
(evil-mode 1)
(global-evil-leader-mode 1)
(evil-leader/set-key
  "tj" 'my-ido-find-tag
  "e" 'find-file
  "\\" 'comment-or-uncomment-region
  "n" 'linum-mode
  "m" 'mc/mark-next-like-this
  "M" 'mc/mark-all-like-this
  )

(yas-global-mode 1)

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)
;; (ido-vertical-mode 1)
;; (helm-mode 1)
;; (require 'helm-config)
;; (helm-mode 1)
(nyan-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)

;; Don't change the font for some headings and titles
(setq solarized-use-variable-pitch nil)

;; Use less bolding
(setq solarized-use-less-bold t)
;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)
(load-theme 'solarized-dark t)

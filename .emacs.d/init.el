;; package related things
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(setq package-list '(
		     evil
		     evil-leader
		     nyan-mode
		     helm
		     spacemacs-theme
		     fill-column-indicator
		     projectile
		     ))

;; (package-refresh-contents)

(dolist (package package-list)
  (unless (package-installed-p package)
        (package-install package)))

;; Configure packages

(require 'evil)
(global-evil-leader-mode 1)
(evil-mode 1)

;; get here or you won't be in evil mode

(nyan-mode 1)

;; ido stuff
(defun my-ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
		(push (prin1-to-string x t) tag-names))
	      tags-completion-table)
    (find-tag (ido-completing-read "Tag: " tag-names))))

(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))

(require 'projectile)
(projectile-global-mode)

;; fci mode
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq fci-rule-width 1)
(setq-default fci-rule-character-color "salmon")
(add-hook 'after-change-major-mode-hook 'fci-mode)
(defun cg-split () (interactive) (split-window-right 90))
(evil-leader/set-key
 "e" 'ido-find-file-in-tag-files
 "b" 'helm-semantic-or-imenu
 "k" 'kill-buffer
 "\\" 'comment-or-uncomment-region
 "v" 'cg-split
 "f" 'my-ido-find-tag
 )
(load-theme 'spacemacs-light t)

;; emacs things
(setq inhibit-splash-screen t) ;; no splash
(setq initial-scratch-message "") ;; no dumb text in your buffer
(setq initial-major-mode 'text-mode) ;; i don't use lisp so much
(setq-default truncate-lines t) ;; Don't wrap lines
(setq backup-inhibited t);disable backup
(setq auto-save-default nil);disable auto save
(setq large-file-warning-threshold nil) ;; no more large file warnings
(blink-cursor-mode 0) ;; no more blinking
(setq ring-bell-function (lambda() (message "*beep*"))) ;; don't ring bell
(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; delete trailing whitespace on save
(setq mode-require-final-newline t) ;; newline at end of document

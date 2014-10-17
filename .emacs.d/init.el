;; setup package manager
(require 'package)
(add-to-list 'package-archives '(
    "marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '(
    "melpa" . "http://melpa.milkbox.net/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Turn off a few things
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq large-file-warning-threshold nil)
(setq inhibit-startup-message t)
(setq backup-inhibited t) ;disable backup
(setq auto-save-default nil) ;disable auto save
(setq ring-bell-function (lambda () (message "*beep*"))) ;; no bell
(setq large-file-warning-threshold nil) ;; no more large file warnings
(blink-cursor-mode 0) ;; no more blinking
(setq initial-scratch-message "") ;; no text in your initial buffer
(setq initial-major-mode 'text-mode) ;; don't use lisp in initial buffer
(menu-bar-mode -1) ;; no menu

;; Turn on a few things
(recentf-mode 1) ;; show recent files
(evil-mode 1) ;; vim keybindings
(subword-mode 1);; stop on camelcase
(which-func-mode 1) ;; show function you are in
(show-paren-mode 1) ;; match parenthesis
(setq require-final-newline t) ;; newline at end of file
(setq-default show-trailing-whitespace t) ;; show trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace);; delete trailing wsp
(global-evil-leader-mode 1) ;; allow leader key

;; change a few behaviors
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; make esc quit things
(when (member "Menlo" (font-family-list))
  (set-face-attribute 'default nil :font "Menlo-15"))

;; setup tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(global-set-key (kbd "TAB") 'self-insert-command) ;; tabs don't autoindent

;; Load soloarized theme
(load-theme 'solarized-light t)
(set-cursor-color "MediumSlateBlue")
(set-face-italic-p 'italic nil) ;; no italics

;; IDO Things
(ido-mode t)

;; IDO M-x
(global-set-key
     "\M-x"
     (lambda ()
       (interactive)
       (call-interactively
        (intern
         (ido-completing-read
          "M-x "
          (all-completions "" obarray 'commandp))))))

;; IDO Find-Tags
(defun my-ido-find-tag ()
    "Find a tag using ido"
    (interactive)
    (tags-completion-table)
    (let (tag-names)
      (mapatoms (lambda (x)
                  (push (prin1-to-string x t) tag-names))
                tags-completion-table)
      (find-tag (ido-completing-read "Tag: " tag-names))))

;; Find files in tags
(defun ido-find-file-in-tag-files ()
      (interactive)
      (save-excursion
        (let ((enable-recursive-minibuffers t))
          (visit-tags-table-buffer))
        (find-file
         (expand-file-name
          (ido-completing-read
           "Project file: " (tags-table-files) nil t)))))

;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)

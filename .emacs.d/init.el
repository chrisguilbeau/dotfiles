;; Turn off a few things
(tool-bar-mode -1) ;; turn off toolbar
(scroll-bar-mode -1) ;; turn off scrollbars
(setq large-file-warning-threshold nil) ;; no warnings for large tags file
(setq inhibit-startup-message t) ;; don't show startup message
(setq backup-inhibited t) ;disable backup
(setq auto-save-default nil) ;disable auto save
(setq ring-bell-function (lambda () (message "*beep*"))) ;; show beep instead of bell
(setq large-file-warning-threshold nil) ;; no more large file warnings
(blink-cursor-mode 0) ;; no more blinking
(setq initial-scratch-message "") ;; no text in your initial buffer
(setq initial-major-mode 'text-mode) ;; don't use lisp in initial buffer
(menu-bar-mode -1) ;; no menu, ever

;; Turn on a few things
(recentf-mode 1) ;; show recent files
(subword-mode 1);; stop on camelcase
(which-func-mode 1) ;; show function you are in
(show-paren-mode 1) ;; match parenthesis
(setq-default show-trailing-whitespace t) ;; show trailing whitespace
(standard-display-ascii ?\t "^I") ;; show tabs as the weird characters that they are

;; Best practices in coding
(add-hook 'before-save-hook 'delete-trailing-whitespace);; delete trailing wsp
(setq require-final-newline t) ;; newline at end of file
(setq-default indent-tabs-mode nil) ;; spaces not tabs

;; ido mode
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "File in tags:: " (tags-table-files) nil t)))))
(setq ido-decorations
      (quote ("\n-> "
              ""
              "\n   "
              "\n   ..."
              "[" "]"
              " [No match]"
              " [Matched]"
              " [Not readable]"
              " [Too big]"
              " [Confirm]"
              )))

;; package manager magic
;; load the package registry
(require 'package)
(push '("melpa" . "http://melpa.milkbox.net/packages/") package-archives)

(defun my-after-init-hook ()
  (load-theme 'solarized-light t)
  (set-cursor-color "MediumSlateBlue")
  (set-face-italic-p 'italic nil) ;; no italics
  ;; configure evil stuff
  (evil-mode 1)
  (global-evil-leader-mode 1)
  (evil-leader/set-key
   "\\" 'comment-or-uncomment-region
   "e" 'ido-find-file-in-tag-files
   "b" 'idomenu
   "o" 'organize-frames
   )
  )

(add-hook 'after-init-hook 'my-after-init-hook)

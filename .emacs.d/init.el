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

;; ediff
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

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

;; list the packages you want
(setq package-list '(
                     evil
                     evil-leader
                     ido-vertical-mode
                     multiple-cursors
                     yasnippet
                     ))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
        (package-install package)))

;; list all files below where your tags file resides
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "File in tags:: " (tags-table-files) nil t)))))


;; turn on and configure packages
(evil-mode 1)
(global-evil-leader-mode 1)
(evil-leader/set-key
  "e" 'ido-find-file-in-tag-files
  "\\" 'comment-or-uncomment-region
  "f" 'projectile-find-file
  "n" 'linum-mode
  "m" 'mc/mark-next-like-this
  "M" 'mc/mark-all-like-this
  )
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(projectile-global-mode)
(setq projectile-globally-ignored-files
      (append '("*.pyc") projectile-globally-ignored-files))
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(ido-vertical-mode 1)
(flx-ido-mode 1)
;; (setq projectile-indexing-method 'native)

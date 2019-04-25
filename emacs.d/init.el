;; package related things
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; UNCOMMENT TO REFRESH!
;; (package-refresh-contents)

(setq
 package-selected-packages '(
                             nyan-mode
                             exec-path-from-shell
                             ;;multiple-cursors
                             spacemacs-theme
                             evil
                             evil-leader
                             evil-commentary
                             ;; evil-easymotion
                             ;; evil-org
                             ;; evil-ediff
                             ;; evil-unimpaired
                             ;; evil-surround
                             ))


(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

;; for osx make sure the path is correct for shell calls
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defun zinit ()
  (message "Initing the z...")
  (interactive)
  (cd "/ZogoTech/src")
  (find-file "/ZogoTech/src")
  (shell-command (concat "zetag"))
  (visit-tags-table "/ZogoTech/src/etags")
  (server-start)
  )

;; (defun edit-init-file ()
;;   (interactive)
;;   (edit "~/.emacs.d/init.el"))

;; multiple cursors
(require 'multiple-cursors)

;; (defun cg-vsplit()
;;   (interactive)
;;   (evil-window-vsplit)
;;   (set-80-columns)
;;   (evil-window-next nil)
;;   )

(setq rg-root default-directory)
(setq rg-cmd "rg --files --path-separator /")
(setq rg-types "")
(setq ido-enable-flex-matching t) ;; allow fuzzy matches
(defun rg-find-files ()
      "Use ido to select a file from the project."
      (interactive)
      ;; get project files
      (setq project-files
	    (split-string
	     (shell-command-to-string
	      (concat rg-cmd " " rg-types " " rg-root)) "\n"))
      ;; populate hash table (display repr => path)
      (setq tbl (make-hash-table :test 'equal))
      (let (ido-list)
      (mapc (lambda (path)
	      (puthash path path tbl)
	      (push path ido-list)
	      )
	    project-files
	    )
      (find-file (gethash (ido-completing-read rg-root ido-list) tbl))))

;; configure packages
(load-theme 'spacemacs-light t)
(nyan-mode 1)
(evil-mode 1)
(evil-commentary-mode 1)
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'rg-find-files
  "b" 'zbuffertags
  "f" 'evilem-motion-find-char
  "t" 'helm-etags-select
  "zz" 'zinit
  "i" 'edit-init-file
  "o" 'show-org-files
  ;; "mm" 'mc/mark-next-like-this
  ;; "mw" 'mc/mark-next-word-like-this
  ;; "mp" 'mc/unmark-next-like-this
  "=" 'set-80-columns
  "n" 'linum-mode
  "v" 'cg-vsplit
  "hg" 'vc-ediff
  "zc" 'vc-dir
  ;; "mm" 'mmm-mode
  )

(defun show-org-files ()
  (interactive)
  (evil-edit "~/ZogoTech/work.org")
  )

(defun zfiles ()
  (interactive)
    (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" "zfiles")))
    (set-process-query-on-exit-flag proc nil)))

(defun zbuffertags ()
  (interactive)
    (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" "zbuffertags" (buffer-file-name)))))
    (set-process-query-on-exit-flag proc nil))

(defun zalltags ()
  (interactive)
    (let ((proc (start-process "cmd" nil "cmd.exe" "/C" "start" "zalltags"))))
    (set-process-query-on-exit-flag proc nil))

(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

(defun toggle-line-numbers ()
  (interactive)
  (line-num-mode)
  )

;; emacs things
(setq backup-inhibited t);disable backup
(setq auto-save-default nil);disable auto save
(setq large-file-warning-threshold nil) ;; no more large file warnings
(setq ring-bell-function (lambda() (message "*beep*"))) ;; don't ring bell
(line-number-mode nil)
(tool-bar-mode -1)
(menu-bar-mode 1)
(scroll-bar-mode -1)
(setq mode-require-final-newline t) ;; newline at end of document
(show-paren-mode 1)
(setq-default indent-tabs-mode nil) ;; no tabs
(setq-default tab-width 4)
(setq indent-line-function 'insert-relative)
(setq ediff-split-window-function 'split-window-horizontally)
(setq javascript-indent-level 2)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)

;; calendar week numbers
(setq calendar-week-start-day 1
      calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'font-lock-function-name-face))

;; adhere to zogotech guidelines
;; no lines over 80
(setq-default
 whitespace-line-column 80
 whitespace-style       '(face lines-tail))
(add-hook 'prog-mode-hook #'whitespace-mode)
;; no trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; spaces not tabs!
(setq c-basic-indent 2)
(setq tab-width 4)
(setq indent-tabs-mode nil)
;; (highlight-tabs)
(setq mode-require-final-newline t) ;; newline at end of document

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(menu-bar-mode nil)
 '(show-paren-mode t))

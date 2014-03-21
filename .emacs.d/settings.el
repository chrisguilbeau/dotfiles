(provide 'settings)		    
(scroll-bar-mode -1)			; hide scrollbars
(setq inhibit-splash-screen t)          ; turn off the splash screen
(setq initial-major-mode 'text-mode)    ; start in text mode not lisp mode
(setq initial-scratch-message "")       ; set initial scratch message to nothing
(setq sort-fold-case t)			; ignore case when sorting
(setq require-final-newline 't)		; require newline at end of file
(setq-default indent-tabs-mode nil)	; Use spaces instead of tabs
(setq tab-width 4)                      ; Length of tab is 4 SPC
(show-paren-mode t)			; Highlight parenthesis
(setq visible-bell t)                   ; No beep when reporting errors
(blink-cursor-mode 0)                   ; No blinking cursor
(setq auto-save-default nil)            ; Disable autosave
(setq make-backup-files nil)            ; Disable backupfiles
(which-function-mode 1)                 ; Show current function
(evil-mode 1)                           ; Turn on vi keybindings

;; (require 'ido)
;; (ido-mode 1)				; turn ido on
;; (setq ido-enable-flex-matching t)	; enable flex matching
;; (setq ido-everywhere t)			; enable for buffers and files

;; set fill column things
(add-hook 'python-mode-hook
          (lambda ()
            (set-fill-column 72)))

;; setup org mode
(setq org-log-done 'time)

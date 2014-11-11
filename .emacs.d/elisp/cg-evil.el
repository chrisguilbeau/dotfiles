(provide 'cg-evil)
(evil-mode 1)
(global-evil-leader-mode) ;; turn on evil leader key
(evil-leader/set-key
 "\\" 'comment-or-uncomment-region
 "e" 'ido-find-file-in-tags
 "b" 'idomenu
 "o" 'organize-frames
 )

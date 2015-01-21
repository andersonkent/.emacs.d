;; ----------------------------------
;; Setup environment for GNU Emacs
;; ----------------------------------




(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(if window-system
    (progn
      ;; Set up my initial window
      (setq default-frame-alist
            '((width . 130) (height . 60)))

      
      ;; Set up my fonts and colors
      (if macosx-p
          (progn
            (set-face-attribute 'default nil :family "Monaco")
            (set-face-attribute 'default nil :height 110)
            (global-set-key (kbd "s-w") 'kill-buffer-and-window)
            (global-set-key (kbd "s-z") 'undo-tree-undo)
            (global-set-key (kbd "s-Z") 'undo-tree-redo)
            (global-set-key (kbd "<s-backspace>") 'backward-kill-line)
            ))
      
      (if mswindows-p
          (progn
            (set-face-attribute 'default nil :family "Consolas")
            (set-face-attribute 'default nil :height 100)
            (global-set-key (kbd "<C-f4>") 'kill-buffer-and-window)
            (setq default-frame-alist '((width . 120) (height . 43)))
            (evil-mode 1)
            ))
      
      (setq default-cursor-type 'bar)
      
      ;; Turn on font-lock in all modes that support it

      ))


(cua-selection-mode 1)
(electric-pair-mode 1)



(if macosx-p
    (progn
      (global-set-key (kbd "<s-right>") 'end-of-line)
      (global-set-key (kbd "<s-left>") 'beginning-of-line)
      (global-set-key (kbd "<s-up>") 'beginning-of-buffer)
      (global-set-key (kbd "<s-down>") 'end-of-buffer)
      (global-set-key (kbd "<kp-delete>") 'delete-char)
      (global-set-key (kbd "s-l") 'buffer-menu)))



(if mswindows-p
    (progn
      (global-set-key (kbd "<M-right>") 'end-of-line)
      (global-set-key (kbd "<M-left>") 'beginning-of-line)
      (global-set-key (kbd "<M-up>") 'beginning-of-buffer)
      (global-set-key (kbd "<M-down>") 'end-of-buffer)
      (global-set-key (kbd "M-s") 'save-buffer)
      (global-set-key (kbd "M-f") 'isearch-forward)
      (global-set-key (kbd "M-l") 'buffer-menu)
      (global-set-key (kbd "<C-prior>") 'previous-buffer)
      (global-set-key (kbd "<C-next>") 'next-buffer)))





;; **************************************************************
;; Ok, let's get down to customizing my keyboard
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "s-.") 'switch-to-next-buffer)
(global-set-key (kbd "s-,") 'switch-to-prev-buffer)

;; I want the buffer menu, not the buffer list
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-d") 'kill-whole-line)

;;(global-set-key (kbd "<escape>") 'execute-extended-command)

(defun my-minibuffer-setup-hook ()
  (local-set-key (kbd "<escape>") 'keyboard-escape-quit))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(visual-line-mode 1)
;;(defun my-text-mode-hook ()
;;  (turn-on-visual-line-mode))
;;(add-hook 'org-mode-hook 'my-text-mode-hook)
;;(add-hook 'text-mode-hook 'my-text-mode-hook)

(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "M-s-<right>") 'select-next-window)
(global-set-key (kbd "M-s-<left>")  'select-previous-window)


;; Some emacs niceness I found on reddit
;; http://zeekat.nl/articles/making-emacs-work-for-me.html
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))


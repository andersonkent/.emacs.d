;; Turn off auto-save and backup files.  They're annoying.
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq inhibit-startup-screen t)

;; Auto-install packages.  This makes it really easy to move between
;; environments.
(require 'package)
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

(defvar my-packages '(dired-x org undo-tree adaptive-wrap magit))

(unless package-archive-contents
  (package-refresh-contents))
(dolist (package my-packages)
  (unless (package-installed-p package)
    (ignore-errors
      (package-install package))))


;; I really hate having to type 'yes' most, but not all, of the time...
(defalias 'yes-or-no-p 'y-or-n-p)

;; Force all new frames into the main frame
;; Add this to your .bashrc:
;; alias em="open -a /Applications/Emacs.app \"$@\""
(setq ns-pop-up-frames nil)

(require 'dired-x)
(setq dired-omit-files-p t)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\.DS_Store$"))

(undo-tree-mode 1)
(global-linum-mode 1)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(global-hl-line-mode 1)
(set-face-background 'hl-line "#efefef")

(set-face-attribute 'font-lock-comment-face nil :foreground "#909090")

(setq c-tab-always-indent 'other)
(setq ediff-split-window-function 'split-window-horizontally)
(setq indent-tabs-mode nil)
(setq tab-always-indent t)
(setq tab-width 4)

(setq org-src-fontify-natively 't)


(require 'tramp)



(require 'paren)
(show-paren-mode 1)
(setq show-paren-style 'expression)
(setq show-paren-delay 0)
(set-face-attribute 'show-paren-match-face nil :background "#d7f7d7")

;; Let's figure out which OS we're running under.  We'll have to map some keys differently 
;; to get the same end results.
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar aquamacs-p (boundp 'aquamacs-version))



(when (fboundp 'adaptive-wrap-prefix-mode)
  (defun my-activate-adaptive-wrap-prefix-mode ()
    "Toggle `visual-line-mode' and `adaptive-wrap-prefix-mode' simultaneously."
    (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
  (add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode))



;; Help dired recognize zip files
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes 
                 '("\\.zip\\'" ".zip" "unzip")))

(defun my-minibuffer-setup-hook ()
  (local-set-key (kbd "<escape>") 'keyboard-escape-quit))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)


(if window-system
    (progn
      (tool-bar-mode -1)
      ))

(if aquamacs-p
    (progn
      (load "~/.emacs.d/init.aquamacs.el"))
    (progn
      (load "~/.emacs.d/init.gnuemacs.el")))

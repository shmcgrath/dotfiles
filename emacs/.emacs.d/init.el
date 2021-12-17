;; Set up package.el to work with MELPA
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; use-package basic install and require
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; ivy and swiper are dependencies of counsel https://github.com/abo-abo/swiper
(use-package counsel)

(use-package dracula-theme
  :init
  ;; Don't change the font size for some headings and titles (default t)
  (setq dracula-enlarge-headings nil)
  ;; Adjust font size of titles level 1 (default 1.3)
  (setq dracula-height-title-1 1.25)
  ;; Adjust font size of titles level 2 (default 1.1)
  (setq dracula-height-title-1 1.15)
  ;; Adjust font size of titles level 3 (default 1.0)
  (setq dracula-height-title-1 1.05)
  ;; Adjust font size of document titles (default 1.44)
  (setq dracula-height-doc-title 1.4)
  ;; Use less pink and bold on the mode-line and minibuffer (default nil)
  (setq dracula-alternate-mode-line-and-minibuffer t))

(use-package evil
  :init
  (setq evil-want-integration t)
  ;; set evil-want-keybinding to nil and install evil-collection
  ;; and evil-magit to be able to use vim movements in other Emacs buffers.
  (setq evil-want-keybinding t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  ;; Enable evil-mode in all buffers
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))

;;(use-package evil-collection)
(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; use evil or emacs marks - which is better / how are they different?
(use-package general
  :config
  (general-create-definer shm/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "C-SPC"
    :global-prefix "C-SPC")
  (shm/leader-keys
   "lb" '(counsel-switch-buffer :which-key "list and switch buffers with counsel")
   "smc" '(set-mark-command :which-key "C-SPC runs the command set-mark-command so restore lost keybind")
   )) 

(use-package goto-chg)

(use-package magit)

;;(use-package markdown-mode
  ;;:commands (markdown-mode gfm-mode)
  ;;:mode (("README\\.md\\'" . gfm-mode))
  ;;:init (setq markdown-command "/usr/bin/pandoc"))

(use-package org)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package try)

(use-package which-key
  :config
  (which-key-mode))

;; set user information
(setq user-full-name "Sarah H. McGrath"
      user-mail-address "sarah@shmcgrath.com"
      calendar-latitude 40.44
      calendar-longitude -79.99
      calendar-location-name "Pittsburgh, PA")
;; stop encode prompts
(set-language-environment "utf-8")

;; Lockfiles, undo files, and backup files
;; do not create lockfiles
(setq create-lockfiles nil)
;; set emacs backup directory
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

;; Disable GUI and visual bell
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq visible-bell t)

;; Set defalt theme
;;(load-theme 'misterioso)
(load-theme 'dracula t)

;; enable line numbers and disable line numbers for some modes
(global-display-line-numbers-mode 1)
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Text prompts
(setq use-dialog-box nil)
;; y or n instead of yes or no in text prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; initial splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Store custom variables in an external file so init.el can be kept in source control
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

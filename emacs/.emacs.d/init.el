;; Set up package.el to work with MELPA
(require 'package)
(setq package-enable-at-startup nil)
;; (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(package-initialize)
(package-refresh-contents)

;; use-package basic install and require
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; set user information
(setq user-full-name "Sarah H. McGrath"
      user-mail-address "sarah@shmcgrath.com"
      calendar-latitude 40.44
      calendar-longitude -79.99
      calendar-location-name "Pittsburgh, PA")
;; stop encode prompts
(set-language-environment "utf-8")

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package org
  :ensure t)
;; packages helm, which-key, try, magit

(use-package helm
  :ensure t)

(use-package magit
  :ensure t)

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Lockfiles, undo files, and backup files
;; do not create lockfiles
(setq create-lockfiles nil)
;; set emacs backup directory
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

;; Disable GUI and visual bell
(setq tool-bar-mode -1)
(setq menu-bar-mode -1)
(setq scroll-bar-mode -1)
(setq visible-bell 1)

;; Set defalt theme
(load-theme 'misterioso)

;; enable line numbers
;;(global-linum-mode 1)

;; Text prompts
(setq use-dialog-box nil)
;; y or n instead of yes or no in text prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; initial splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Store custom variables in an external file so init.el can be kept in source control
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

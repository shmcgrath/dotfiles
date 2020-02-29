;; Set up package.el to work with MELPA
(require 'package)
;; (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Disable GUI and visual bell
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq visible-bell 1)

;; Text prompts
(setq use-dialog-box nil)
;; y or n instead of yes or no in text prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; Store custom variables in an external file so init.el can be kept in source control
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

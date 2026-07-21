;; Set up package.el to work with MELPA
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
; (package-refresh-contents) casues refresh on restart
(unless package-archive-contents
  (package-refresh-contents))

;; use-package basic install and require
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; stop encode prompts
(set-language-environment "utf-8")

;; wrap all text globally
(global-visual-line-mode 1)

;; wrap for orgmode only
(add-hook 'org-mode-hook #'visual-line-mode)

;; Lockfiles, undo files, and backup files
;; do not create lockfiles
(setq create-lockfiles nil)
;; set emacs backup directory
(setq backup-directory-alist `(("." . "~/.local/state/emacs/backup")))
;; set emacs auto-save directory
(setq auto-save-file-name-transforms
      `((".*" "~/.local/state/emacs/auto-save" t)))

;; Disable GUI and visual bell
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq visible-bell t)
(set-fringe-mode 10)

;; Save command history
(use-package savehist
  :custom
  (savehist-file "~/.local/state/emacs/savehist")
  (history-length 10000)
  :config
  (savehist-mode +1))


;; Text prompts
(setq use-dialog-box nil)
;; y or n instead of yes or no in text prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; initial splash screen
; (setq inhibit-splash-screen t)
;       initial-major-mode 'org-mode)

;; enable line numbers and disable line numbers for some modes
(global-display-line-numbers-mode 1)
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Set defalt theme
(load-theme 'misterioso)
; (load-theme 'modus-operandi-tinted)

;(use-package catppuccin-theme
  ;:config
  ;(setq catppuccin-flavor 'latte)
  ;(load-theme 'catppuccin :no-confirm)
  ;a
  ;(catppuccin-reload))

(set-face-attribute 'default nil
                    :family "CommitMono Nerd Font Mono"
                    :height 140)

(set-fontset-font t 'symbol (font-spec :family "CommitMono Nerd Font Mono") nil 'prepend)

(use-package nerd-icons
  :custom
  (nerd-icons-font-family "CommitMono Nerd Font Mono"))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;nerd-icons-completion          20260412.243   available    melpa    Add icons to completion candidate$
;nerd-icons-corfu               20250729.1544  available    melpa    Icons for Corfu via nerd-icons
;nerd-icons-grep                20250625.1435  available    melpa    Add nerd-icons to grep-mode


; (use-package evil
;   :init
;   (setq evil-want-integration t)
;   ;; set evil-want-keybinding to nil and install evil-collection
;   ;; and evil-magit to be able to use vim movements in other Emacs buffers.
;   (setq evil-want-keybinding t)
;   (setq evil-want-C-u-scroll t)
;   (setq evil-want-C-i-jump nil)
;   (setq evil-normal-state-cursor 'box
; 	evil-insert-state-cursor 'bar
; 	evil-visual-state-cursor 'box)
;   (setq evil-esc-delay 0)
;   :config
;   ;; Enable evil-mode in all buffers
;   (evil-mode 1)
;   (define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
;   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Nested prompts
(setq enable-recursive-minibuffers t)

;;(use-package evil-collection)
; (use-package evil-org
;   :after (evil org)
;   :hook (org-mode . (lambda () evil-org-mode))
;   :config
;   (require 'evil-org-agenda)
;   (evil-org-agenda-set-keys))

					; (use-package goto-chg)

;;(use-package markdown-mode
;;:commands (markdown-mode gfm-mode)
;;:mode (("README\\.md\\'" . gfm-mode))
;;:init (setq markdown-command "/usr/bin/pandoc"))


; (use-package which-key
;   :config
;   (which-key-mode))

(use-package magit)
(use-package org)

(use-package notmuch
  :commands (notmuch notmuch-search notmuch-tree)
  :config
  ;; Always use the tree view when opening notmuch.
  (setq notmuch-show-only-matching-messages nil)

  ;; Display newest search results first.
  (setq notmuch-search-oldest-first nil)

  ;; Saved searches shown on the startup screen.
  (setq notmuch-saved-searches
        '((:name "Inbox"
                 :query "tag:inbox and not tag:deleted"
                 :key "i")
          (:name "Unread"
                 :query "tag:unread and not tag:deleted"
                 :key "u")
          (:name "Flagged"
                 :query "tag:flagged"
                 :key "f")
          (:name "Sent"
                 :query "tag:sent"
                 :key "s")
          (:name "Drafts"
                 :query "tag:draft"
                 :key "d")
          (:name "All Mail"
                 :query "*"
                 :key "a")))
)

; (use-package evil-collection
;   :after (evil)
;   :config
;   (evil-collection-notmuch-setup))
;
; (evil-define-key 'normal 'global
;   (kbd "-") #'dired-jump)
; (with-eval-after-load 'dired
;   (define-key dired-mode-map (kbd "-") #'dired-jump))

;; Vertico (completion UI)
(use-package vertico
	:init (vertico-mode))
  ; :custom
  ; (vertico-cycle t))

;; Orderless (fuzzy matching)
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion orderless))
     (buffer (styles orderless basic))
     (symbol (styles orderless basic)))))

;; Marginalia (annotations in minibuffer)
(use-package marginalia
	:init (marginalia-mode))

;; Consult (search/navigation commands)
(use-package consult)
(setq consult-fd-args
      "fd --full-path --color=never --hidden")
; (setq consult-fd-args
;       "fd --full-path --color=never --hidden --follow --exclude .git")

;; Embark (actions on candidates)
(use-package embark)
	; :bind
	; (("C-." . embark-act) ;; main action key
	;  ("C-;" . embark-dwim))) ;; “do what I mean”

;; Embark integration for Consult
(use-package embark-consult
	:hook
	(embark-collect-mode . consult-preview-at-point-mode))

;; set up fzf-lua equivalent
; (defvar shm-find-map (make-sparse-keymap))
;
; (global-set-key (kbd "C-p") shm-find-map)
; (with-eval-after-load 'evil
;   (define-key evil-normal-state-map (kbd "C-p") shm-find-map))
;
; (define-key shm-find-map (kbd "f") #'consult-fd)
; (define-key shm-find-map (kbd "g") #'consult-ripgrep)
; (define-key shm-find-map (kbd "b") #'consult-buffer)
; (define-key shm-find-map (kbd "r") #'consult-recent-file)

(use-package clipetty
  :bind ("M-k" . clipetty-kill-ring-save))

(use-package elfeed
  :commands elfeed
  :config
  (setq elfeed-feeds
        '(
          ("https://www.theguardian.com/football/rss" football sport)
          ("https://planet.kernel.org/rss20.xml" linux kernel)
          ))

  (setq elfeed-db-directory "~/.local/share/elfeed")

  ; (setq elfeed-search-filter "@1-months +unread")

  (setq elfeed-search-title-max-width 100))

; move categories from article to tags

(defun my/elfeed-categories-to-tags (entry)
  (when-let ((categories (elfeed-meta entry :categories)))
    (apply #'elfeed-tag
           entry
           (mapcar
            (lambda (category)
              (intern
               (downcase
                (replace-regexp-in-string
                 " "
                 "-"
                 category))))
            categories))))

(add-hook 'elfeed-new-entry-hook
          #'my/elfeed-categories-to-tags)


;; Store custom variables in an external file so init.el can be kept in source control
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(load-file "~/.emacs.d/private.el")

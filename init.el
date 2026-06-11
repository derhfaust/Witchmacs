;;; init.el --- Witchmacs -*- lexical-binding: t -*-
;; Make emacs startup faster
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
 
(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
 
(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))
 
(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
    gc-cons-percentage 0.1))
 
(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
;;

;; Initialize melpa repo
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
        '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; These are built-in — never try to install them from MELPA
(use-package org-indent
  :ensure nil
  :diminish)

(use-package abbrev
  :ensure nil
  :diminish)

;; Load Witchmacs theme
(load-theme 'Witchmacs t)

;; Load config.org for init.el configuration
;; use-package is built-in since Emacs 29
(unless (>= emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t
      use-package-expand-minimally t)

;; Silence native-comp warnings from old packages
(setq native-comp-async-report-warnings-errors 'silent)
(setq native-comp-deferred-compilation t)

;; Restore GC after startup
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 2 1000 1000))))
;; Emacs 30 face-box compatibility shim
;; Fixes themes that use :style unspecified in :box specs
(defun witchmacs/fix-face-box (spec)
  "Sanitize :box plist for Emacs 30 compatibility."
  (if (and (listp spec) (plist-member spec :style))
      (let ((s (plist-get spec :style)))
        (if (eq s 'unspecified)
            (org-plist-delete spec :style)
          spec))
    spec))

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d44b39527b22d5afe361d35bf894893a21ba4279a14fd1037a909150f5f74a3a"
	 default))
 '(package-selected-packages
   '(async auto-package-update beacon company-c-headers dashboard
		   diminish htmlize ido-vertical-mode magit page-break-lines
		   spaceline swiper switch-window treemacs-evil
		   treemacs-icons-dired tron-legacy-theme undo-tree
		   yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq byte-compile-warnings '(not obsolete))

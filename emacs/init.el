(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/") t)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(defvar my-packages
  '(elpy
    material-theme
    zenburn-theme
    color-theme-sanityinc-tomorrow
    function-args))

;; Install packages
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      my-packages)

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)

;; function-args
(require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))

;; Python packages
;;(require 'elpy)
;;(elpy-enable)

(require 'color-theme-sanityinc-tomorrow)

(menu-bar-mode -1) ;; hide menu bar
(tool-bar-mode -1) ;; hide tool bar
(setq inhibit-startup-message t) ;; hide the startup message
;;(load-theme 'material t) ;; load material theme
;;(load-theme 'zenburn t) ;; load material theme
;;(load-theme 'color-theme-sanityinc-tomorrow t) ;; load material theme
(load-theme 'monokai t)
(global-linum-mode t) ;; enable line numbers globally

(setq whitespace-style '(face trailing tabs))
(global-whitespace-mode)

;;(set-default-font "Inconsolata 11")
;;(set-default-font "FiraCode 11")
;;(set-default-font "Roboto Mono-11:weight=regular")
(set-default-font "Roboto Mono:style=Regular")
;;(set-default-font "Hack:style=Regular")
;;(set-default-font "Source Code Pro:style=Regular")
;;(set-default-font "Roboto Medium 11")
;;(set-default-font "Roboto Bold 11")
;;(set-default-font "Roboto Bold Condensed 11")
;;(set-default-font "Monaco 11")
;;(set-default-font "Dejavu Sans Mono 9")
;; init.el ends here

;;(set-frame-font "Source Code Pro-11:style=Regular" nil t)

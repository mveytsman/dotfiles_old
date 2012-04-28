(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-ruby starter-kit-js starter-kit-eshell starter-kit-bindings color-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "2e130c0ce1b485fde7ba3b65ebc68cdd883ef6a7" "810a580e75aca47fc70e40f2adbebbcd27b978f9" "0174d99a8f1fdc506fa54403317072982656f127" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; used to be maxim.el
;; fonts
;Doesn't work on windows :(
;(set-face-attribute 'default nil :font "Deja Vu Sans Mono-12")
;(set-default-font "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1")

;; the visual bell is broken on macs in emacs 23
(setq ring-bell-function 'ignore)

;; add texbin to path
;;(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin" ":/usr/local/bin"))
;;(setq exec-path (append exec-path '("/usr/texbin" "/usr/local/bin")))
;;(require 'tex-site)
; I prefer M-tab for hippie expand
(global-set-key (read-kbd-macro "<M-tab>") 'hippie-expand)

;; smex is like ido but for M-x
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


(global-set-key (kbd "C-C-h") 'backward-kill-word)

;; Colors!

;; major modes
(setq c-default-style "linux"
      c-basic-offset 4)
;; org stuff
(setq org-startup-indent 0
      org-hide-leading-stars 1
      org-startup-folded 0)

;;make scripts executable
 (add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)

;; ispell broken on OS X
(setq-default ispell-program-name "/usr/local/bin/aspell")

;; solarize theme
(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark)


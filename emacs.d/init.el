; == Initialization == 
;i hate beeps
(setq ring-bell-function 'ignore)
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar my-packages '(starter-kit starter-kit-ruby starter-kit-js starter-kit-eshell starter-kit-bindings color-theme coffee-mode find-file-in-project idle-highlight-mode ido-ubiquitous inf-ruby magit markdown-mode paredit quack rvm smex shell-switcher haml-mode yaml-mode rinari ecb-snapshot)
  "A list of packages to ensure are installed at launch.")
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; A quick & ugly PATH solution to Emacs on Mac OSX. Referencing the
   (if (eq system-type 'darwin)
         (setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:" (getenv "PATH"))))
;; Load path for non package.el packages
(add-to-list 'load-path "~/.emacs.d/vendor/deft/")
;; package specific initialization 
(smex-initialize)
(require 'rvm)
;magit uses the wrong git for some reason
(custom-set-variables
 '(magit-git-executable "/usr/local/bin/git"))
(rvm-use-default)
(require 'shell-switcher)
(setq shell-switcher-mode t)
;(add-to-list 'load-path "~/.emacs.d/vendor/emacs-pry")
;(require 'pry)
(load "~/.emacs.d/vendor/nxhtml/autostart.el")
(setq
      nxhtml-global-minor-mode t
      mumamo-chunk-coloring 'sublime-colored
      mumamo-background-colors nil
      nxhtml-skip-welcome nil
      indent-region-mode t
      rng-nxml-auto-validate-flag nil
      nxml-degraded t)
(add-to-list 'auto-mode-alist '(".erb\\'" . eruby-html-mumamo-mode))
(add-to-list 'auto-mode-alist '(".jad\\'" . java-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(custom-set-variables
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
)
;; Mumamo is making emacs 24 freak out:
(setq byte-compile-warnings '(not nresolved
                                  free-vars
                                  callargs
                                  redefine
                                  obsolete
                                  noruntime
                                  cl-functions
                                  interactive-only
                                  ))

;; OS X breaks some things
(if (eq system-type 'darwin)
    (progn
      ;ispell is broken
      (setq-default ispell-program-name "/usr/local/bin/aspell")
      ;visual bell looks crappy
      (setq visible-bell nil)))
; ruby-mode add stupid comments to files
(setq ruby-insert-encoding-magic-comment nil)
;; ECB mode
(setq stack-trace-on-error t)
(setq ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
(ecb-activate)
(ecb-byte-compile)
;;racket mode
(require 'quack)

;; deft mode
(require 'deft)
(setq deft-extension "org") 
(setq deft-text-mode 'org-mode)
(setq deft-use-filename-as-title t)
(setq deft-directory "~/Dropbox/org")

; == Themes and Fonts ==
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("723d8e038750a51aa9d6f1000a6f5047f343a10291a07dfb30c8f35fa9bfe8ec" "810a580e75aca47fc70e40f2adbebbcd27b978f9" "0174d99a8f1fdc506fa54403317072982656f127" default))))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
 )
;; Default font choice --- Consolas on windows, otherwise Inconsolata
(if (eq system-type 'windows-nt)
    (set-default-font "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1")
  (set-face-attribute 'default nil :font "Inconsolata Sans Mono-14"))

;; solarize theme
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-color-theme-solarized")
(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/emacs-color-theme-solarized")
(load-theme 'solarized-dark)
 
; == Custom Commands ==
(defun run-ipython ()
  (interactive)
  (term "ipython"))

; == Key Bindings ==
;; I prefer M-tab for hippie expand
(global-set-key (read-kbd-macro "<M-tab>") 'hippie-expand)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-C-h") 'backward-kill-word)
;;in OS X enable fullscrean lion support with Apple-shift-f
(if (eq system-type 'darwin)
  (progn
    (global-set-key (kbd "<s-return>") 'ns-toggle-fullscreen)
    (global-set-key (kbd "<C-return>") 'ns-toggle-fullscreen)))
(global-set-key (kbd "C-,") 'run-ipython)
(global-set-key (kbd "C-.") 'run-pry)

; == Text Layout and Modes ==
;;do line wrapping right
;(global-visual-line-mode t)
;(toggle-word-wrap 1)
;(auto-fill-mode 1)
;(setq-default word-wrap -1)
;(setq comment-auto-fill-only-comments t)
;(add-hook 'emacs-lisp-mode
;          '(lambda() (auto-fill-mode -1)))
;(add-hook 'eruby-html-mumamo-mode
;           '(lambda() (auto-fill-mode -1)))
;(add-hook 'after-change-major-mode-hook 
;           '(lambda() (auto-fill-mode -1)))
;;4 space tabs
(setq-default tab-width 4)
(setq c-default-style "linux"
      c-basic-offset 4)
;;make scripts executable
 (add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)
;; org stuff
(setq org-startup-indent 0
      org-hide-leading-stars 1
      org-startup-folded 0)

;;idiomatic coffee-script is 2 tabs per space
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; start server
(server-start)

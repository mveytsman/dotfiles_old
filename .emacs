;(tool-bar-mode -1)
;(menu-bar-mode -1)
;(scroll-bar-mode -1)
;; w3m and wget
(require 'w3m-load)
(require 'wget)
(setq w3m-default-display-inline-images 1)
(setq w3m-use-cookies 1)
(setq auto-mode-alist

      (append auto-mode-alist
	      '(("\\.[hg]s$"  . haskell-mode)
		("\\.hi$"     . haskell-mode)
		("\\.l[hg]s$" . literate-haskell-mode))))

(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)
(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)
;(require 'emms-setup)
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq ispell-program-name "aspell")

;(emms-all)
;(emms-default-players)
;(load "~/.emacs.d/twittering-mode/twittering-mode.el")
;(require 'twittering-mode)
;(setq twittering-username "mveytsman")


;(add-to-list 'load-path "~/emacs/org")
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files
      (list "~/org/current.org"))
(setq org-agenda-custom-commands
    '(("w" todo "WAITING" nil)
    ("n" todo "NEXT" nil)
    ("d" "Agenda + Next Actions" ((agenda) (todo "NEXT"))))
)

(setq org-todo-keywords (quote ((sequence "TODO(t)" "CANCELLED(c)" "NEXT(n)" "WAITING(w)" "DONE(d)" ))))

(setq org-use-fast-todo-selection t)

(require 'ido)
(ido-mode t)
(ido-everywhere 0)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f11>") 'calendar)

;(load-file "~/.emacs.d/cedet/common/cedet.el")
;(add-to-list 'load-path "~/.emacs.d/ecb-snap")

;(require 'ecb)

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/mingus/")
(add-to-list 'load-path "~/.emacs.d/magit/")

(require 'haml-mode)

(require 'libmpdee)
(require 'mingus)


(setq c-basic-offset 4)
(load "magit.el")
(require 'magit)
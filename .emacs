;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)


(require 'color-theme)
;(color-theme-initialize)
(color-theme-charcoal-black)

(require 'org)
;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
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
(ido-everywhere 1)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f11>") 'calendar)

;(load-file "~/.emacs.d/cedet/common/cedet.el")
;(add-to-list 'load-path "~/.emacs.d/ecb-snap")

(load-file "~/.emacs.d/django-html-mode.el")
(add-to-list 'auto-mode-alist '("\\.djhtml$" . django-html-mode))


(setq c-basic-offset 4)
(load "magit.el")
(require 'magit)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(ansi-color-for-comint-mode-on)


(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(load-file "~/.emacs.d/espresso.el")
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
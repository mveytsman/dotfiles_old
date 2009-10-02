(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
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
(set-default-font "Bitstream Vera Sans Mono-12")
(color-theme-initialize)
(color-theme-charcoal-black)
;(require 'emms-setup)
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq ispell-program-name "aspell")
;(emms-all)
;(emms-default-players)
   
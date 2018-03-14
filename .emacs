;;; Commentary:
;;; .emacs file for game development using Phaser javascript, SDL C++. Can be used for general web and C/C++ dev.
;;; gets packages from 3 sources
;;; font customised for Hung, change if need


;;; Code:

(require 'package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auto-save-default nil)
 '(global-column-number-mode 1)
 '(global-linum-mode 1)
 '(line-number-mode nil)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ;;("melpa-stable" . "https://stable.melpa.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(safe-local-variable-values
   (quote
    ((eval setq flycheck-gcc-include-path
	   (list "." "/home/hung/gamedev/cpp/Framework/" "/usr/include/SDL2/" "/usr/include/c++/4.8/"))
     ))))

(package-initialize)
(load-theme 'solarized-dark t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 104 :width normal))))
 '(company-scrollbar-bg ((t (:background "#3d3d3d"))))
 '(company-scrollbar-fg ((t (:background "#303030"))))
 '(company-tooltip ((t (:inherit default :background "#292929"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face)))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; General

;; env variables in emacs same as shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;smooth scrolling
(setq scroll-step 1) ;; for keyboard only

;;don't load init buffer
(setq inhibit-startup-screen 1)

;; turn off toolbar
(tool-bar-mode -1)

;; customisation to easily move between windows
(global-set-key (kbd "C-M-p") 'windmove-up)
(global-set-key (kbd "C-M-d") 'windmove-left)
(global-set-key (kbd "C-M-f") 'windmove-right)
(global-set-key (kbd "C-M-n") 'windmove-down)


;; frame size and pos
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(width . 95))
;;(add-to-list 'default-frame-alist '(left . 695))
;;(add-to-list 'default-frame-alist '(top . 0))


;; backup
(setq backup-directory-alist `(("." . "~/.backupEmacs")))

;; iedit, which is editing same region, similar to multiple cursor but no select
(define-key global-map (kbd "C-;") 'iedit-mode)

;; company setting for all
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)


;; auto-pair
(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)


(require 'multiple-cursors)
(global-set-key (kbd "C-x C-,") 'set-rectangular-region-anchor)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; open stuff vert split
(defun 2-windows-vertical-to-horizontal ()
  (let ((buffers (mapcar 'window-buffer (window-list))))
    (when (= 2 (length buffers))
      (delete-other-windows)
      (set-window-buffer (split-window-horizontally) (cadr buffers)))))

(add-hook 'emacs-startup-hook '2-windows-vertical-to-horizontal)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bash

(defun my-elisp-mode()

  (global-company-mode)

  (global-flycheck-mode)

  (define-key emacs-lisp-mode-map (kbd "M-RET") 'company-complete) 
  
  )

(add-hook 'emacs-lisp-mode-hook 'my-elisp-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Web/Phaser/JS - not used, tern uninstalled, just reinstall and uncomment

;; web-mode and tern
;;(require 'web-mode)
;;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))
;;
;;(defun my-web-mode-hook ()
;;  "Hooks for Web mode."
;;  (tern-mode t)
;;  (setq web-mode-markup-indent-offset 2)
;;  (setq web-mode-css-indent-offset 2)
;;  (setq web-mode-code-indent-offset 2)
;;  (setq web-mode-extra-auto-pairs
;;      '(("erb"  . (("beg" "end")))
;;        ("php"  . (("beg" "end")
;;                  ("beg" "end")))
;;	   ))
;;  (setq web-mode-enable-auto-pairing t)
;;  (setq web-mode-enable-css-colorization t)  
;;  )
;;
;;(add-hook 'web-mode-hook  'my-web-mode-hook)
;;
;;(eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; C/C++
;; set .h to open in c++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))



;;linux style namespace no indent
(defconst my-cc-style
  '("linux"
    (c-basic-offset . 4)
    (c-offsets-alist . ((innamespace . [0]))
		     )))

(c-add-style "my-cc-style" my-cc-style)

(defun my-c-mode () 

  
  (c-set-style "my-cc-style")
  (require 'cc-mode)

  
  (setq tab-width 4)
  (setq-default indent-tabs-mode nil)

  ;;flycheck
  (global-flycheck-mode)
  (setq flycheck-checker 'c/c++-gcc)
  (setq flycheck-gcc-language-standard "c++11")

  ;; yasnippet for c/c++
  ;;(require 'yasnippet)
  ;;(yas-global-mode 1)
  

  (require 'semantic/bovine/gcc)
  ;; this allows cedet to re-parse the buffer itself when idle (updates)
  (global-semantic-idle-scheduler-mode 1)
  (global-semanticdb-minor-mode 1)
  (semantic-mode 1)

  ;; jump to function key binding
  (define-key c++-mode-map (kbd "C-c j") 'semantic-complete-jump)

  (require 'company)
  (setq-local company-backends '((company-semantic
                                  company-c-headers
                                  company-capf
                                  company-files
                                  company-dabbrev-code
                                  company-gtags
                                  company-dabbrev
                                  )))
  (global-company-mode)
  ;;(setq company-echo-delay 0)
  ;;(setq company-idle-delay 0)
  (setq company-dabbrev-downcase 0)
  
  ;;(add-to-list 'company-backends 'company-c-headers)
  (define-key c++-mode-map (kbd "M-RET") 'company-complete)

  
  ;; doxymacs config for commenting in doxygen style in c++
  (add-to-list 'load-path "~/share/emacs/site-lisp")
  (require 'doxymacs)

  (defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
  
  )

(add-hook 'c-mode-hook 'my-c-mode)
(add-hook 'c++-mode-hook 'my-c-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Python

(defun my-python-mode ()
  ;; yasnippet
  (require 'yasnippet)
  (yas-global-mode 1)

  ;; add rosemacs for robot programming
  ;; (add-to-list 'load-path "/opt/ros/indigo/share/emacs/site-lisp")
  ;; (require 'rosemacs-config)

  (require 'company)
  (add-to-list 'company-backends 'company-jedi)

  (global-flycheck-mode)

  (package-initialize)
  (elpy-enable)
  
  )

(add-hook 'python-mode-hook 'my-python-mode)

(defun my-lua-mode ()

  (require 'company)
  (require 'company-lua)
  (setq-local company-backends '((company-lua
                                  company-etags
                                  company-dabbrev-code
                                  company-yasnippet)))
  (yas-global-mode 1)
  (global-flycheck-mode)
)

(add-hook 'lua-mode-hook 'my-lua-mode)

;; changing company mode tooltip colour
(require 'color)

(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
   `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
   `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
   `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
   `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
   `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))



(provide '.emacs)
;;; .emacs ends here

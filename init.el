(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired

  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)





;; use-package
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))





;; -----company-mode-----
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)



;; Omnisharp
(setq omnisharp-server-executable-path "c:/Users/<user-name>/AppData/Roaming/.emacs.d/omnisharp-emacs/OmniSharp.exe")

(defun my-csharp-mode-setup ()
  (omnisharp-mode)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4))

(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)
;; (add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load
 'company
  '(add-to-list 'company-backends 'company-omnisharp))

(add-hook 'csharp-mode-hook #'company-mode)





;; php
(require 'php-mode)
(setq ac-php-tags-path "C:/Users/<user-name>/.ac-php")
(add-hook 'php-mode-hook
          '(lambda ()
            ;; Enable company-mode
            (company-mode t)
            (require 'company-php)

            ;; Enable ElDoc support (optional)
            (ac-php-core-eldoc-setup)

            (set (make-local-variable 'company-backends)
             '((company-ac-php-backend company-dabbrev-code)
               company-capf company-files))

            ;; Jump to definition (optional)
            (define-key php-mode-map (kbd "M-]")
             'ac-php-find-symbol-at-point)

            ;; Return back (optional)
            (define-key php-mode-map (kbd "M-[")
             'ac-php-location-stack-back)))


;; -----PYTHON-----
;; (setq py-install-directory "C:\\Users\\<user-name>\\AppData\\Roaming\\.emacs.d\\elpa\\python-mode-6.2.3")
;; (add-to-list 'load-path py-install-directory)
;; (require 'python-mode)

;; ;; anaconda-mode
;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
;; (setq python-shell-interpreter "C:\\Users\\<user-name>\\bin\\cpython\\python.exe")

;; ;; company-anaconda
;; (eval-after-load "company"
;;  '(add-to-list 'company-backends 'company-anaconda))


;; ;; flycheck
;; (defun flycheck-python-setup ()
;;  (flycheck-mode))
;; (add-hook 'python-mode-hook #'flycheck-python-setup)

;; (defun flycheck-python-linters ()
;;  (flycheck-disable-checker 'python-pycompile)
;;  (flycheck-add-next-checker 'python-flake8 'python-pylint))
;; (add-hook 'flycheck-mode-hook #'flycheck-python-linters)


;; javascript
(setq-default js-indent-level 2)

(use-package js2-mode
    :ensure t
    :mode "\\.js\\'"
    :config
    (setq-default js2-ignored-warnings '("msg.extra.trailing.comma")))

(use-package js2-refactor
    :ensure t
    :config
    (js2r-add-keybindings-with-prefix "C-c C-m")
    (add-hook 'js2-mode-hook 'js2-refactor-mode))

(use-package web-mode
    :ensure t
    :mode ("\\.html\\'")
    :config
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-engines-alist
          '(("django" . "focus/.*\\.html\\'")
            ("ctemplate" . "realtimecrm/.*\\.html\\'"))))





;; markdown
(use-package markdown-mode
    :ensure t
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
           ("\\.md\\'" . markdown-mode)
           ("\\.markdown\\'" . markdown-mode))
    :init (setq markdown-command "multimarkdown"))





;; ;; environment managment
;; (use-package exec-path-from-shell
;;     :ensure t
;;     :config
;;     (exec-path-from-shell-initialize))





;; ace-window
(global-set-key (kbd "M-o") 'ace-window)






;; KEY MAPPING
(global-set-key (kbd "C-S-k") 'shrink-window)
(global-set-key (kbd "C-S-j") 'enlarge-window)
(global-set-key (kbd "C-S-h") 'shrink-window-horizontally)
(global-set-key (kbd "C-S-l") 'enlarge-window-horizontally)






;; Start window size
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 100))






;; THEMES
(add-to-list 'custom-theme-load-path "C:/Users/<user-name>/AppData/Roaming/.emacs.d/themes")
;;(load-theme 'doneburn t)
;;(load-theme 'azure t)
;;(load-theme 'railscasts-reloaded t)
;;(load-theme 'darkokai t)
;;(load-theme 'basic t)

;;(load-theme 'basic t)
;;(load-theme 'blackboard t)
;;(load-theme 'twilight-bright t)
;;(load-theme 'cherry-blossom t)


;; FONT
;;(set font for all windows. don't keep window size fixed
;;(set-frame-font "Hack" nil t)
;;(set-frame-font "Dejavu Sans Mono-10.1" nil t)
;;(set-frame-font "Monego-10.1" nil t)
;;(set-frame-font "Roboto Mono-10.1" nil t)
;;(set-frame-font "SF Mono-10.1" nil t)






;; System-type definition

;; (defun system-is-linux()
;;     (string-equal system-type "gnu/linux"))

(defun system-is-windows()
  (string-equal system-type "windows-nt"))


;; Start Emacs as a server
;; (when (system-is-linux)
;;   (require 'server)
;;   (unless (server-running-p)
;;     (server-start)))


;; ;; Unix path-variable
;; (when (system-is-linux)
;;   (setq unix-sbcl-bin          "/usr/bin/sbcl")
;;   (setq unix-init-path         "~/.emacs.d")
;;   (setq unix-init-ct-path      "~/.emacs.d/plugins/color-theme")
;;   (setq unix-init-ac-path      "~/.emacs.d/plugins/auto-complete")
;;   (setq unix-init-slime-path   "/usr/share/common-lisp/source/slime/")
;;   (setq unix-init-ac-dict-path "~/.emacs.d/plugins/auto-complete/dict"))

; MS Windows path-variable
(when (system-is-windows)
    (setq win-init-path         "C:/.emacs.d")
    (setq win-init-ct-path      "C:/.emacs.d/plugins/color-theme")
    (setq win-init-ac-path      "C:/.emacs.d/plugins/auto-complete")
    (setq win-init-slime-path   "C:/slime")
    (setq win-init-ac-dict-path "C:/.emacs.d/plugins/auto-complete/dict"))

;; My name and e-mail adress
(setq user-full-name   "%user-name%")
(setq user-mail-adress "%user-mail%")


;; Dired
(require 'dired)
(setq dired-recursive-deletes 'top)


;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t)
(setq imenu-use-popup-menu nil)
(global-set-key (kbd "<f6>") 'imenu)

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")

;; Inhibit startup/splash screen
(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t)

;; Show-paren-mode settings
(show-paren-mode t)
(setq show-paren-style 'expression)


;; Electric-modes settings
(electric-pair-mode    1)
(electric-indent-mode 1)

;; Delete selection
(delete-selection-mode t)


;; Disable GUI components
(tooltip-mode      -1)
(menu-bar-mode     -1) ;; отключаем графическое меню
(tool-bar-mode     -1) ;; отключаем tool-bar
(scroll-bar-mode   -1) ;; отключаем полосу прокрутки
(blink-cursor-mode -1) ;; курсор не мигает
(setq use-dialog-box     nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore)



;; Disable backup/autosave files
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

;; Linum plugin
(require 'linum) ;; вызвать Linum
(line-number-mode   t) ;; показать номер строки в mode-line
(global-linum-mode  t) ;; показывать номера строк во всех буферах
(column-number-mode t) ;; показать номер столбца в mode-line
(setq linum-format " %d")

;; Line wrapping
(setq word-wrap          t)
(global-visual-line-mode t)


;; IDO plugin
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)


;; Buffer Selection and ibuffer settings
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer)
(global-set-key (kbd "<f2>") 'bs-show)


;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t)
(setq font-lock-maximum-decoration t)

;; Indent settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width          2)
(setq-default c-basic-offset     2)
(setq-default standart-indent    2)
(setq-default lisp-body-indent   2)
(global-set-key (kbd "RET") 'newline-and-indent)
(setq lisp-indent-function  'common-lisp-indent-function)

;; End of file newlines
(setq require-final-newline    t)
(setq next-line-add-newlines nil)


;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)


;; Delete trailing whitespaces, format buffer and untabify when save buffer
(defun format-current-buffer()
    (indent-region (point-min) (point-max)))
(defun untabify-current-buffer()
    (if (not indent-tabs-mode)
        (untabify (point-min) (point-max)))
    nil)

(add-to-list 'write-file-functions 'delete-trailing-whitespace)
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(package-selected-packages
;;    (quote
;;     (hemisu-theme ace-window flycheck company-anaconda anaconda-mode company use-package))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (phpunit omnisharp company-php ac-php php-mode csharp-mode ace-window company web-mode use-package markdown-mode js2-refactor))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

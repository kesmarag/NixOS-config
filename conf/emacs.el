
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  2. Core Emacs Behavior & UI
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      ;; --- Basic Information ---
      (setq user-full-name "Costas Smaragdakis"
            user-mail-address "kesmarag@aegean.gr")

      ;; --- UI Customization ---
      (setq inhibit-startup-screen t)         ; Disable the splash screen
      (tool-bar-mode -1)                       ; Disable the toolbar
      (menu-bar-mode -1)                       ; Disable the menubar
      (tab-bar-mode -1)                        ; Disable the tabbar
      (blink-cursor-mode -1)                   ; No blinking cursor
      (setq ring-bell-function 'ignore)        ; Silence the audible bell
      (show-paren-mode 1)                      ; Highlight matching parentheses
      (setq-default initial-scratch-message   ; Custom scratch message
                    (concat ";; " (format-time-string "%A %d %B %Y") "\n\n"))

      ;; Disable scroll bars for a cleaner look
      (defun kesmarag/disable-scroll-bars (frame)
        (modify-frame-parameters frame
                                 '((vertical-scroll-bars . nil)
                                   (horizontal-scroll-bars . nil))))
      (add-hook 'after-make-frame-functions 'kesmarag/disable-scroll-bars)
      (set-scroll-bar-mode nil) ; Also disable for existing frames

      ;; --- Frame and Window Behavior ---
      (add-to-list 'default-frame-alist '(fullscreen . maximized)) ; Start maximized
      (setq-default frame-title-format '("GNU Emacs : %f"))
      (setq frame-resize-pixelwise t)
      (setq frame-inhibit-implied-resize t)

      ;; --- File Handling ---
      (setq make-backup-files nil)              ; No `~` backup files
      (setq auto-save-default nil)              ; No `#` auto-save files
      (defalias 'yes-or-no-p 'y-or-n-p)         ; Use y/n instead of yes/no
      (setq delete-by-moving-to-trash t)        ; Move deleted files to trash

      (setq tab-bar-format
            '(tab-bar-format-tabs
              tab-bar-format-add-tab
              tab-bar-format-align-right
              tab-bar-format-menu-bar))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  3. Theming & Appearance (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      ;; Doric themes config
      ;;(setq doric-themes-to-toggle '(doric-dark doric-light))
      ;;(setq doric-themes-to-rotate doric-themes-collection)
      (doric-themes-select 'doric-dark)
      ;;(global-set-key (kbd "<f5>") 'doric-themes-toggle)
      ;;(global-set-key (kbd "C-<f5>") 'doric-themes-select)
      ;;(global-set-key (kbd "M-<f5>") 'doric-themes-rotate)

      (defun kesmarag/set-gui-font ()
        (when (display-graphic-p)
          (set-frame-font "Aporetic Sans Mono-13" nil t)))
      (kesmarag/set-gui-font)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (select-frame frame)
                  (kesmarag/set-gui-font)))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  4. Editing Enhancements (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      (setq select-enable-clipboard t)
      (global-subword-mode 1)
      (setq-default indent-tabs-mode nil)
      (setq-default tab-width 4)
      
      ;; --- Completion Framework ---
      (vertico-mode)
      (setq vertico-count 4)
      (setq vertico-cycle t)
      
      (setq completion-styles '(orderless)
            completion-category-defaults nil
            completion-category-overrides '((file (styles . (partial-completion)))))

      (global-corfu-mode)
      (global-set-key (kbd "C-<tab>") 'completion-at-point)
      (setq corfu-cycle t)
      (setq corfu-auto nil)
      (setq corfu-separator ?\s)
      (setq corfu-quit-at-boundary 'never)

      (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
      
      (add-to-list 'completion-at-point-functions #'cape-file)
      (add-to-list 'completion-at-point-functions #'cape-dabbrev)
      
      ;; --- Other Utilities ---
      (which-key-mode)
      (global-undo-tree-mode)
      (setq undo-tree-visualizer-timestamps t)
      (setq undo-tree-visualizer-diff t)
      (global-set-key (kbd "M-;") 'comment-dwim-2)
      (setq olivetti-body-width 128)
      (yas-global-mode 1)
      (marginalia-mode)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  5. File and Project Management (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      (add-hook 'dired-mode-hook 'hl-line-mode)
      (setq dired-recursive-copies 'always)
      (setq dired-recursive-deletes 'always)
      (setq dired-listing-switches "-GFhlv --group-directories-first")
      (setq dired-dwim-target t)
      (add-hook 'dired-mode-hook #'dired-hide-details-mode)
      (add-hook 'dired-mode-hook #'dired-sort-toggle-or-edit)
      
      (global-set-key (kbd "C-x g") 'magit-status)
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  6. Programming & Development (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      ;; --- LSP ---
      (add-hook 'c++-mode-hook 'lsp)
      (add-hook 'python-mode-hook 'lsp)
      
      (with-eval-after-load 'flymake
        (set-face-attribute 'flymake-error nil :underline nil)
        (set-face-attribute 'flymake-warning nil :underline nil)
        (set-face-attribute 'flymake-note nil :underline nil))
        
      (add-hook 'lsp-mode-hook 'lsp-ui-mode)

      ;; --- Python ---
      (setq python-shell-interpreter "/home/kesmarag/.venvs/0/bin/python")

      ;; --- LaTeX ---
      (add-hook 'LaTeX-mode-hook
                (lambda ()
                  (push '(output-pdf "PDF Tools") TeX-view-program-selection)
                  (visual-line-mode)
                  (reftex-mode)
                  (turn-on-auto-fill)
                  (prettify-symbols-mode)
                  (outline-minor-mode)))
      (add-hook 'LaTeX-mode-hook
                (lambda ()
                  (add-to-list 'TeX-command-list '("XeLaTeX" "%`%(mode)%' %t" TeX-run-TeX nil t))
                  (setq TeX-save-query nil)
                  (setq TeX-show-compilation t)))
      (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

      ;;; direnv configuration
      (use-package direnv
        :ensure t
        :config
        (direnv-mode)
        :bind (("C-x d" . direnv-update-environment))
      )


      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  7. Org Mode (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      (setq org-export-backends '(latex md))
      (setq org-export-headline-levels 8)
      (setq org-babel-load-languages '((python . t)))
      (require 'org-tempo)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  8. Other Packages (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      (pdf-tools-install :no-query)
      (setq-default pdf-view-display-size 'fit-page)
      (setq pdf-annot-activate-created-annotations t)
      
      (setq notmuch-show-logo nil)
      (setq notmuch-search-oldest-first nil)
      (add-hook 'notmuch-hello-mode-hook (lambda () (display-line-numbers-mode 0)))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  9. Custom Functions & Keybindings (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      ;; Custom clipboard functions
      (defun kesmarag/copyq-select-and-yank ()
        "Fetch the CopyQ history item-by-item, select one, and yank it."
        (interactive)
        (let* ((count-str (shell-command-to-string "copyq count"))
               (count (string-to-number (string-trim count-str)))
               (history-list
                (let ((items '()))
                  (dotimes (i count)
                    (add-to-list 'items (shell-command-to-string
                                         (format "copyq read %d" i))))
                  (nreverse items)))
               (selected-item (completing-read "Yank from CopyQ: " history-list nil t)))
          (when selected-item
            (kill-new selected-item)
            (yank))))

      (defun kesmarag/kill-others ()
        "Kill all buffers except essential ones and close other windows."
        (interactive)
        (mapc 'kill-buffer
              (cl-remove-if
               (lambda (x)
                 (or (eq x (current-buffer))
                     (member (buffer-name x)
                             '("*Messages*" "*scratch*" "*vterm*" "*Bookmark List*"))))
               (buffer-list)))
        (delete-other-windows))

      ;; --- Global Keybindings ---
      (global-set-key (kbd "C-c y") 'kesmarag/copyq-select-and-yank)
      (global-set-key (kbd "C-`") 'toggle-input-method)
      (global-set-key (kbd "C-c c") 'org-capture)
      (global-set-key (kbd "C-x t") 'vterm)
      (global-set-key (kbd "C-x C-n") 'next-buffer)
      (global-set-key (kbd "C-x C-p") 'previous-buffer)
      (global-set-key (kbd "C-x k") 'kill-current-buffer)
      (global-set-key (kbd "C-x C-b") 'ibuffer)
      (define-key key-translation-map (kbd "C-t") (kbd "C-x"))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;  10. Local Configurations (from init.el)
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

      (setq default-input-method "greek")

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;
      ;;;  KESMARAG-MODELINE.EL contents are embedded here
      ;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (defun kesmarag-modeline-string-truncate (str)
        (if (>(length str) 24)
            (concat (substring str 0 16) "..." (substring str -8 nil))
          str))

      (defcustom prot-modeline-string-truncate-length 9
        "String length after which truncation should be done in small windows."
        :type 'natnum)

      (defvar-local kesmarag-modeline-name
        '(:eval (list (propertize " 𝞉" 'face 'shadow)
                 (format " %s "
                        (propertize (kesmarag-modeline-string-truncate (buffer-name)) 'face 'success))))
        "format the buffer name")

      (defvar-local kesmarag-modeline-major
        '(:eval (list (propertize "λ" 'face 'shadow)
                 (format " %s"
                        (propertize (symbol-name major-mode) 'face 'bold))))
        "format the major mode")

      (defvar-local kesmarag-modeline-input-method
          '(:eval
            (when current-input-method-title
              (propertize (format " %s" current-input-method-title)
                          'face 'error)))
        "Mode line construct to report the multilingual environment.")

      (defvar-local kesmarag-modeline-what-line
        '(:eval
          (let ((line-number (format-mode-line "%l")))
            (concat
             (propertize " # " 'face 'shadow)
             (propertize (format "%s " line-number 'face 'bold)))))
        "Format for displaying the current line in the mode-line.")

      (defvar-local kesmarag-modeline-time
          '(:eval (list (propertize " " 'face 'shadow)
                      (format " %s " (propertize (format-time-string "%H:%M") 'face 'bold))))
        "format the major mode")

      (defun kesmarag-inbox-indicator ()
        (with-temp-buffer
            (insert-file-contents "/home/kesmarag/.config/textind/inbox")
            (format "%d"  (string-to-number (buffer-string)))))

      (defvar-local kesmarag-modeline-inbox
          '(:eval
            (when (mode-line-window-selected-p)
              (list (propertize " μ " 'face 'shadow)
            (kesmarag-inbox-indicator))))
        "Mode line")

      (put 'kesmarag-modeline-what-line 'risky-local-variable t)
      (put 'kesmarag-modeline-input-method 'risky-local-variable t)
      (put 'kesmarag-modeline-time 'risky-local-variable t)
      (put 'kesmarag-modeline-major 'risky-local-variable t)
      (put 'kesmarag-modeline-name 'risky-local-variable t)
      (put 'kesmarag-modeline-eglot 'risky-local-variable t)
      (put 'kesmarag-modeline-inbox 'risky-local-variable t)

      (setq-default mode-line-format
              '("%e"
                kesmarag-modeline-input-method
                kesmarag-modeline-what-line
                kesmarag-modeline-name
                " "
                kesmarag-modeline-major
                " "
                kesmarag-modeline-eglot
                (:eval (propertize " " 'display '((space :align-to (- right-fringe 8)))))
                kesmarag-modeline-inbox
                ))

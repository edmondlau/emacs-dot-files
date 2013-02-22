;; Load path
(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/elisp/python-mode.el-6.0.3")
(add-to-list 'load-path "~/elisp/scala-mode")

;; Quora
;; (add-to-list 'load-path "~/ans/etc/gtags")

;; (add-to-list 'load-path "~/elisp/color-theme-6.6.0")
;;(add-to-list 'load-path "~/elisp/emacs-color-theme-solarized")
;; (require 'color-theme-solarized)

;; (add-to-list 'load-path "~/google-gtags-2.0.0")

(server-start)

;; Font setup
(set-default-font "-apple-Consolas-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1")
(setq c-basic-offset 2)

;; Coding shortcuts
(global-set-key [?\C-;] 'goto-line)
(global-set-key [?\C-l] 'goto-line)

;; Region manipulation
;; (global-set-key "\C-x\\" 'uncomment-region)
;; (global-set-key "\C-x/" 'comment-region)
(global-set-key "\C-x/" 'comment-dwim)
(global-set-key "\C-x\\" 'comment-dwim)
(defalias 'sir 'string-insert-rectangle)
(defalias 'dr 'delete-rectangle)

;; Autocomplete
(global-set-key [(control t)] 'dabbrev-expand)
(global-set-key [(meta t)] 'tags-search)

;; Prefer backward-kill-word over Backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; Regular expression search
(global-set-key "\M-s" 'isearch-forward-regexp)
(global-set-key "\M-q" 'c-fill-paragraph)
(global-set-key "\M-r" 'isearch-backward-regexp)
(global-set-key "\C-s" 'isearch-forward)
(global-set-key "\C-r" 'isearch-backward)

(defalias 'qrr 'query-replace-regexp)
(defalias 'rr 'replace-regexp)

;; Window cycling
(defun prev-window()
  (interactive)
  (other-window -1))
  
(global-set-key "\C-o" 'other-window)
(global-set-key "\M-o" 'prev-window)

;; Use mac key as meta
(setq ns-command-modifier 'meta)

;; Buffer Management
(defalias 'rb 'revert-buffer)

;; Shell
(global-set-key "\C-z" 'shell)

;; Remapping to the Alt-x combo
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; global minor modes for completion
;; offer completions for buffers, commands
(icomplete-mode 1)
;; show all buffer names on C-x b
(iswitchb-mode 1)
;; allow going to previous/next window layouts with control+left/right.
(winner-mode 1)

;; show column numbers
(column-number-mode 1)

(require 'anything-config)
(global-set-key "\C-xb" 'anything)

(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-create
        anything-c-source-recentf
        anything-c-source-files-in-current-dir+
        my-anything-c-source-file-search
       ;; anything-c-source-etags-select
       ;; anything-c-source-occur
       ;; anything-c-source-browse-code
       ;; anything-c-source-find-files        
       ;; anything-c-source-file-cache
       ;; anything-c-source-locate
       ;; anything-c-source-ffap-guesser
       ;; anything-c-source-man-pages
       ;; anything-c-source-complex-command-history
       ;; anything-c-source-extended-command-history
       ;; anything-c-source-emacs-commands
       ;; anything-c-source-simple-call-tree-functions-callers
       ;; anything-c-source-simple-call-tree-callers-functions
        ))

(defun my-get-source-directory (path)
  "/home/edmond/ans/"
  )

(defvar my-anything-c-source-file-search
  '((name . "File Search")
    (init . (lambda ()
              (setq anything-default-directory
                    default-directory)))
    (candidates . (lambda ()
                    (let ((args
                           (format
                            (concat "'%s' "
                                    "-path '*/.git' -prune -o "
                                    "-path '*/int' -prune -o "
                                    "-path '*/target' -prune -o "
                                    "-path '*/tmp' -prune -o "
                                    "-iregex '.*%s.*' -a "
                                    "-not -name '*.pyc' -a "
                                    "-not -name '*.class' "                                    
                                    "-print"
                                    )
                            (my-get-source-directory anything-default-directory)
                            anything-pattern)))
                      (start-process-shell-command "file-search-process" nil
                                                   "find" args))))
    (type . file)
    (requires-pattern . 2)
    (delayed))
    "Source for searching matching files recursively.")

;; ;; Org mode configurations
;; (require 'org-install)

;; ;; (global-set-key "\C-cA" 'org-archive-to-archive-sibling)
;; (global-set-key "\C-cA" 'org-archive-subtree)
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-cb" 'org-iswitchb)
;; (setq org-log-done t)

;; (setq org-hide-leading-stars nil)
;; (setq org-odd-levels-only nil)
;; (setq org-fast-tag-selection-single-key 0)
;; (setq org-tags-match-list-sublevels 1)
;; (setq org-use-fast-todo-selection t)

;; (setq org-agenda-files (list "~/notes/life.org"))
;; (setq org-startup-folded 'content)

;; ecmascript
(add-to-list 'auto-mode-alist '("\\.as$" . ecmascript-mode))
(add-to-list 'auto-mode-alist '("\\.mxml$" . ecmascript-mode))
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))

(autoload 'ecmascript-mode "ecmascript-mode" "ECMA script editing mode." t)

(global-set-key "\C-c\C-c" 'compile)
(global-set-key "\C-\M-c" 'compile)

;; python
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("BUILD" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(require 'fill-column-indicator)

;; scala
(setq auto-mode-alist (cons '("\\.scala$" . scala-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("scala" . scala-mode)
                                   interpreter-mode-alist))
(autoload 'scala-mode "scala-mode" "Scala editing mode." t)

(add-hook 'scala-mode-hook 'fci-mode)

;; javascript
;; (add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
;; (autoload 'javascript-mode "javascript-mode" "javascript mode" t)

(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(autoload 'js-mode "js" "javascript mode" t)

(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("php" . php-mode)
                                   interpreter-mode-alist))
(autoload 'php-mode "php-mode" "PHP editing mode." t)

;; Status bar
(set-face-foreground 'modeline "grey")
(set-face-background 'modeline "black")

;; extras
;; (setq transient-mark-mode 0)
(require 'magit)
(global-set-key "\C-x\C-g" 'magit-status)

(setq-default fill-column 80)

;; gtags
(require 'gtags)
(global-set-key "\M-." 'gtags-show-tag-locations-regexp)
(global-set-key "\C-x." 'gtags-show-tag-locations)
(global-set-key "\C-x;" 'gtags-show-callers)
(global-set-key "\C-x'" 'gtags-show-callers)
(global-set-key "\C-x," 'gtags-pop-tag)

(setq gtags-default-mode 'python-mode)
(setq gtags-output-mode 'single-line-grouped)
(setq gtags-use-gtags-mixer t)

(global-set-key "\M-'" 'next-match)

; (global-set-key "\M-." 'find-tag)
; (setq anything-c-etags-tag-file-dir "~/ans/quora/")
;; (global-set-key "\C-x\M-." 'find-tag-regexp)

;; (remove-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key "\C-xw" 'delete-trailing-whitespace)

;; (load "~/elisp/sbt.el")

(defun mo-toggle-identifier-naming-style ()
  "from foo_bar_baz -> fooBarBaz"
  (interactive)
  (let* ((symbol-pos (bounds-of-thing-at-point 'symbol))
         case-fold-search symbol-at-point cstyle regexp func)
    (unless symbol-pos
      (error "No symbol at point"))
    (save-excursion
      (narrow-to-region (car symbol-pos) (cdr symbol-pos))
      (setq cstyle (string-match-p "_" (buffer-string))
            regexp (if cstyle "\\(?:\\_<\\|_\\)\\(\\w\\)" "\\([A-Z]\\)")
            func (if cstyle
                     'capitalize
                   (lambda (s)
                      (concat (if (= (match-beginning 1)
                                     (car symbol-pos))
                                  ""
                                "_")
                              (downcase s)))))
      (goto-char (point-min))
      (re-search-forward regexp nil t)
      (while (re-search-forward regexp nil t)
        (replace-match (funcall func (match-string 1))
                       t nil))
            (widen))))

(global-set-key "\M-u" 'mo-toggle-identifier-naming-style)

;; ensime

;; Load the ensime lisp code...
;; (add-to-list 'load-path "~/elisp/ensime_2.9.0-1-0.6.1/elisp/")
;; (require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; MINI HOWTO:
;; Open .scala file. M-x ensime (once per project)

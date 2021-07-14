
;; -*- coding: utf-8-unix -*-
;; パッケージ管理
;; 初期化
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(fset 'package-desc-vers 'package--ac-desc-version)
(package-initialize)

;; elisp/にロードパスを通す
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; Exec-path form login shell
;(exec-path-from-shell-initialize)

;; Windows
(when (eq window-system 'w32)
  ;; ; 環境変数(msys2)
  ;; (setenv "PATH" (concat "C:/msys64/usr/bin;" (getenv "PATH")))
  ;; (add-to-list 'exec-path "C:/msys64/usr/bin;")
  ;; ;; msys2 shell
  ;; (setq shell-file-name "C:/msys64/usr/bin/bash")
  ;; (setq shell-command-switch "-c")
  ;; (setq explicit-shell-file-name "C:/msys64/usr/bin/bash")

  ; Frame Size
  (set-frame-size (selected-frame) 80 32)

  ; Client server
  (when (require 'server nil t)
    (server-start)))

;;IME-Patch
(when (locate-library "w32-ime")
    (progn
      (w32-ime-initialize)
      (setq default-input-method "W32-IME")
      (setq-default w32-ime-mode-line-state-indicator "[Ee]")
      (setq w32-ime-mode-line-state-indicator-list '("[Ee]" "[い]" "[Ee]"))
))

;;Font
(when (or (eq window-system 'w32) (eq window-system 'x))
  (progn
    (set-face-attribute 'default nil :family "Monaco" :height 100)
    (setq face-font-rescale-alist '(("Noto Sans CJK JP" . 1.08)))
    (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Noto Sans CJK JP"))))

(when (eq window-system 'mac)
  (progn
    (set-face-attribute 'default nil :family "Monaco" :height 120)
    (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "\214\271\217_\203S\203V\203b\203NL Regular"))
    (setq face-font-rescale-alist '(("\214\271\217_\203S\203V\203b\203NL Regular" . 1.2)))))

(setq-default line-spacing 0.2)

;; メニューバーを消す
(menu-bar-mode nil)

;; 行末の空白を保存時に消去
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; 終了時にオートセーブファイルを削除
(setq delete-auto-save-files t)

;; No TABs
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; *.~ などのバックアップファイルを作る
(setq make-backup-files t)
;; .#* などのバックアップファイルを作る
(setq auto-save-default t)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; ツールバーなし
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; 列数を表示する
(column-number-mode t)

;; 行数を表示する
(global-linum-mode t)

;; カーソルの点滅を止める
(blink-cursor-mode 1)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; C-kで行全体を削除する
(setq kill-whole-line t)

;; 改行後インデント
(global-set-key "\C-m" 'newline-and-indent)

;;C-c cでM-x compile
(global-set-key "\C-cc" 'compile)

;; dired
(require 'dired-x)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; beep音を消す
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; Proxy for package-install
;(setq url-proxy-services '(("http" . "proxy.ccst.numazu-ct.ac.jp:8080")))

;;Auto-install
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/auto-install/"))
;; (require 'auto-install)
;; ;;(auto-install-update-emacswiki-package-name nil)
;; (auto-install-compatibility-setup)

;;Auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'arduino-mode)
(add-to-list 'ac-modes 'promela-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'rjsx-mode)
(add-to-list 'ac-modes 'typescript-mode)
(add-to-list 'ac-modes 'javascript-mode)
(add-to-list 'ac-modes 'css-mode)
; リテラル，コメントでも有効
(setq ac-disable-faces nil)

;;Smartparens
(require 'smartparens-config)
(smartparens-global-mode t)

;; Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-enabled-themes '(tango-dark))
 '(desktop-globals-to-save
   '(desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history kill-ring))
 '(desktop-save-mode nil)
 ;'(markdown-command "pandoc")
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(package-selected-packages
   '(arduino-mode add-node-modules-path flycheck typescript-mode web-mode rjsx-mode yaml-mode exec-path-from-shell ox-pandoc htmlize cmake-mode kconfig-mode ac-slime haskell-mode slime markdown-preview-mode ac-geiser geiser swift3-mode smartparens flex-autopair ido-vertical-mode yatex yasnippet smex qml-mode lua-mode ido-completing-read+ auto-complete auto-compile)))

;; M-x compile が呼び出されたとき自動でSave
(setq compilation-ask-about-save nil)

;; doxymacs mode
(require 'doxymacs)

;; custom c-mode hook
(defun custom-c-mode-hook ()
  (c-set-style "user")
  (setq c-tab-always-indent t)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset tab-width)
  (c-set-offset 'innamespace 0)
  (define-key c-mode-base-map "\C-cc" 'compile)
  (setq compilation-scroll-output t)
  (doxymacs-mode 1)
  (setq doxymacs-doxygen-style "Qt")
  (setq doxymacs-command-character "@")
  (linum-mode 1)
  (subword-mode 1)
  (setq linum-format "%4d ")
  ;; (local-set-key (kbd "<RET>") 'electric-indent-just-newline)
  ;(setq comment-start "// " comment-end "")
  (setq compilation-ask-about-save nil))

(add-hook 'c-mode-common-hook 'custom-c-mode-hook)
(add-hook 'c++-mode-hook 'custom-c-mode-hook)

;; QML-mode
(autoload 'qml-mode "qml-mode" "Editing Qt Declarative." t)
(add-to-list 'auto-mode-alist '("\\.qml$" . qml-mode))

;; ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)       ; あいまいマッチ
(when (fboundp 'ido-vertical-mode)      ; 縦に
  (ido-vertical-mode 1))
(when (fboundp 'ido-completing-read+)
  (require 'ido-completing-read+))
(ido-ubiquitous-mode 1)                 ; completing-readをido化
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;Yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/yasnippets"
        ))
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)     ; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)        ; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file) ; 既存スニペットを閲覧・編集する
(yas-global-mode 1)
(add-to-list 'yas/key-syntaxes "(w_.)" t)                               ; Add syntaxes for lisp function
; Save position before yasnippet execution
(defun yas/my-save-marker ()
  (setq yas/my-pre-marker (point-marker))
  (setq yas/my-post-marker (set-marker (make-marker) (1+ (point)))))
(add-hook 'yas/before-expand-snippet-hook 'yas/my-save-marker)
; Swap ac-source-yasnippet and ac-source-functions
(defun ac-emacs-lisp-mode-setup ()
  (setq ac-sources (append '(ac-source-features ac-source-yasnippet ac-source-functions ac-source-variables ac-source-symbols) ac-sources)))

;; YaTeX
; 拡張子が .tex なら yatex-mode に
(setq auto-mode-alist
  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-block-delimiter-face ((t :inherit font-lock-negation-char-face)))
 '(web-mode-comment-face ((t :inherit font-lock-comment-face)))
 '(web-mode-css-at-rule-face ((t :inherit font-lock-keyword-face)))
 '(web-mode-css-color-face ((t :inherit font-lock-reference-face)))
 '(web-mode-css-pseudo-class-face ((t :inherit font-lock-function-name-face)))
 '(web-mode-css-rule-face ((t :inherit font-lock-function-name-face)))
 '(web-mode-current-element-highlight-face ((t :inherit font-lock-builtin-face)))
 '(web-mode-doctype-face ((t :inherit font-lock-doc-face)))
 '(web-mode-error-face ((t :inherit font-lock-warning-face)))
 '(web-mode-function-call-face ((t :inherit font-lock-function-name-face)))
 '(web-mode-function-name-face ((t :inherit font-lock-function-name-face)))
 '(web-mode-html-attr-name-face ((t :inherit font-lock-variable-name-face)))
 '(web-mode-html-attr-value-face ((t :inherit font-lock-string-face)))
 '(web-mode-html-tag-bracket-face ((t :inherit font-lock-negation-char-face)))
 '(web-mode-html-tag-face ((t :inherit font-lock-function-name-face)))
 '(web-mode-javascript-comment-face ((t :inherit font-lock-comment-face)))
 '(web-mode-javascript-string-face ((t :inherit font-lock-string-face)))
 '(web-mode-json-comment-face ((t :inherit font-lock-comment-face)))
 '(web-mode-json-key-face ((t :inherit font-lock-keyword-face)))
 '(web-mode-json-string-face ((t :inherit font-lock-string-face)))
 '(web-mode-keyword-face ((t :inherit font-lock-keyword-face)))
 '(web-mode-param-name-face ((t :inherit font-lock-variable-name-face)))
 '(web-mode-preprocessor-face ((t :inherit font-lock-preprocessor-face)))
 '(web-mode-server-comment-face ((t :inherit font-lock-comment-face)))
 '(web-mode-string-face ((t :inherit font-lock-string-face)))
 '(web-mode-type-face ((t :inherit font-lock-type-face)))
 '(web-mode-variable-name-face ((t :inherit font-lock-variable-name-face)))
 '(web-mode-warning-face ((t :inherit font-lock-warning-face))))

;; Promela (SPIN)
(add-to-list 'load-path "~/.emacs.d/elisp/promela-mode") ; location where you cloned promela-mode
(require 'promela-mode)
;; (add-to-list 'auto-mode-alist '("\\.pml\\'" . promela-mode))
;; (autoload 'promela-mode "promela-mode" "PROMELA mode" nil t)
(setq auto-mode-alist
      (append
       (list (cons "\\.promela$"  'promela-mode)
	     (cons "\\.spin$"     'promela-mode)
	     (cons "\\.pml$"      'promela-mode)
	     ;; (cons "\\.other-extensions$"     'promela-mode)
	     )
       auto-mode-alist))

;; Geiser (Racket, Scheme)
(require 'geiser)
(setq geiser-active-implementations '(racket))

;; Markdown / preview mode
(setq markdown-preview-stylesheets (list "github.css"))

;; Kconfig-mode
(require 'kconfig-mode)

;; Org-mode
; enable line-breaking
(setq org-startup-truncated nil)
; 上文字、下文字の自動変換をオフ
(setq org-use-sub-superscripts nil)
(setq org-export-with-sub-superscripts nil)

; ox-latex
(setenv "PATH" (concat "/Library/TeX/texbin;" (getenv "PATH")))
(setq exec-path (parse-colon-path (getenv "PATH")))
(require 'ox-latex)
(let ((systype system-type))
  (cond ((eq systype 'darwin)
         (setq org-latex-pdf-process
               '("platex %f"
                 "platex %f"
                 "dvipdfmx %b.dvi"
                 "open %b.pdf")))
        (t
         (setq org-latex-pdf-process
               '("platex %f"
                 "platex %f"
                 "dvipdfmx %b.dvi")))))
; customjsarticle
(setq oxlatex-jsarticle-options
      (with-temp-buffer
        (insert-file-contents "~/.emacs.d/oxlatex-jsarticle-options.txt")
        (buffer-string)))
(setq oxlatex-tempclasslist '("customjsarticle"))
(add-to-list 'oxlatex-tempclasslist
             oxlatex-jsarticle-options
             t)
(nconc oxlatex-tempclasslist
       '(("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             oxlatex-tempclasslist)

(add-to-list 'org-latex-classes
             '("jsreport"
               "\\documentclass[dvipdfmx,11pt,report]{jsbook}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))
(add-to-list 'org-latex-classes
             '("jsbook"
               "\\documentclass[dvipdfmx,11pt]{jsbook}"
               ("\\part{%s}" . "\\part*{%s}")
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

; しおりの文字化け対策
(add-to-list 'org-latex-packages-alist '("" "pxjahyper") t)
; hyperrefの設定
(add-to-list 'org-latex-packages-alist "\\hypersetup{setpagesize=false}" t)
(add-to-list 'org-latex-packages-alist "\\hypersetup{bookmarksnumbered=true}" t)
(add-to-list 'org-latex-packages-alist "\\hypersetup{colorlinks=true}" t)
(add-to-list 'org-latex-packages-alist "\\hypersetup{linkcolor=blue}" t)
(add-to-list 'org-latex-packages-alist "\\hypersetup{citecolor=red}" t)
; その他のパッケージの追加
(add-to-list 'org-latex-packages-alist '("" "amsmath, amssymb") t)
(add-to-list 'org-latex-packages-alist '("" "bm") t)
(add-to-list 'org-latex-packages-alist '("" "ascmac") t)
(add-to-list 'org-latex-packages-alist '("" "url") t)
(add-to-list 'org-latex-packages-alist '("" "here") t)
(add-to-list 'org-latex-packages-alist '("" "listings, jlisting") t)
; 目次で改ページ
(setq org-latex-toc-command "\\tableofcontents \\clearpage")

;; ox-pandoc
;; (let ((systype system-type))
;;   (if (eq systype 'darwin)
;;       (progn
;;         (setenv "PATH" (concat "/usr/local/Cellar/pandoc/2.9.2.1/bin;" (getenv "PATH")))
;;         (add-to-list 'exec-path "/usr/local/Cellar/pandoc/2.9.2.1/bin;"))))
(require 'ox-pandoc)

;; Latex compile to pdf
(let ((systype system-type))
  (when (eq systype 'darwin)
    (defun latex-compile(filename)
      (interactive "bFilename:")
      (let ((fixedname (car (split-string filename "\\."))))
        (shell-command (concat "platex " fixedname ".tex && dvipdfmx " fixedname ".dvi && open " fixedname ".pdf"))))))

;; web-mode settings for TSX
(add-to-list 'auto-mode-alist '("\\.[jt]sx\\'" . web-mode))
(defun custom-web-mode-hook ()
  (flycheck-mode +1)
  (setq web-mode-attr-indent-offset nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq web-mode-enable-current-element-highlight t)
  (let ((case-fold-search nil))
  (highlight-regexp "\\_<number\\|string\\|boolean\\|enum\\|unknown\\|any\\|void\\|null\\|undefined\\|never\\|object\\|symbol\\_>" 'font-lock-type-face)))
(add-hook 'web-mode-hook 'custom-web-mode-hook)
;; Inherit colors from font-lock


;; ESLint
(eval-after-load 'web-mode
  '(add-hook 'web-mode-hook #'add-node-modules-path))
(eval-after-load 'rjsx-mode
  '(add-hook 'rjsx-mode-hook #'add-node-modules-path))
(eval-after-load 'typescript-mode
  '(add-hook 'typescript-mode-hook #'add-node-modules-path))

;; FlyC
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; ;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'js-mode)


;; 環境をJP, UTF-8に
(set-locale-environment nil)
(set-language-environment "Japanese")
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (prefer-coding-system 'utf-8-unix)
         (set-default-coding-systems 'utf-8-unix)
         (set-buffer-file-coding-system 'utf-8-unix)
         (setq file-name-coding-system 'cp932))
        ((eq ws 'ns)
         (require 'ucs-normalize)
         (prefer-coding-system 'utf-8-hfs)
         (setq file-name-coding-system 'utf-8-hfs)
         (setq locale-coding-system 'utf-8-hfs))))

;; TWE
;(setenv "MWSDK_ROOT" "/Users/kawa/MWSTAGE/MWSDK")

;; SLIME
; slime
(setq inferior-lisp-program "clisp")
; auto-complete
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

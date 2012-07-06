(require 'xcscope)
      (define-key global-map [(control f3)]  'cscope-set-initial-directory)
      (define-key global-map [(control f4)]  'cscope-unset-initial-directory)
      (define-key global-map [(control f5)]  'cscope-find-this-symbol)
      (define-key global-map [(control f6)]  'cscope-find-global-definition)
      (define-key global-map [(control f7)]
        'cscope-find-global-definition-no-prompting)
      (define-key global-map [(control f8)]  'cscope-pop-mark)
      (define-key global-map [(control f9)]  'cscope-next-symbol)
      (define-key global-map [(control f10)] 'cscope-next-file)
      (define-key global-map [(control f11)] 'cscope-prev-symbol)
      (define-key global-map [(control f12)] 'cscope-prev-file)
      (define-key global-map [(meta f9)]  'cscope-display-buffer)
      (define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)

(global-set-key "\C-h" 'backward-delete-char)
(global-set-key [kp-home]  'beginning-of-buffer) ; [Home]
(global-set-key [home]     'beginning-of-buffer) ; [Home]
(global-set-key [kp-end]   'end-of-buffer)       ; [End]
(global-set-key [end]      'end-of-buffer)       ; [End]

(global-set-key "\C-l" 'goto-line) ; [Ctrl]-[L]

(setq-default c-basic-offset 4)
(setq c-default-style "linux"
          c-basic-offset 4)

;(add-hook 'c-mode-common-hook
;           (lambda ()
;           (c-set-style "linux")))

;; scroll one line at a time (less "jumpy" than defaults)
;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(defvar LIMIT 1)
(defvar time 0)
(defvar mylist nil)

(defun time-now ()
   (car (cdr (current-time))))

(defun bubble-buffer ()
   (interactive)
   (if (or (> (- (time-now) time) LIMIT) (null mylist))
       (progn (setq mylist (copy-alist (buffer-list)))
          (delq (get-buffer " *Minibuf-0*") mylist)
          (delq (get-buffer " *Minibuf-1*") mylist)))
   (bury-buffer (car mylist))
   (setq mylist (cdr mylist))
   (setq newtop (car mylist))
   (switch-to-buffer (car mylist))
   (setq rest (cdr (copy-alist mylist)))
   (while rest
     (bury-buffer (car rest))
     (setq rest (cdr rest)))
   (setq time (time-now)))

(global-set-key [f4] 'bubble-buffer)

(load-library "hideshow")

    (defun toggle-selective-display (column)
      (interactive "P")
      (set-selective-display
       (or column
           (unless selective-display
             (1+ (current-column))))))

    (defun toggle-hiding (column)
      (interactive "P")
      (if hs-minor-mode
          (if (condition-case nil
                  (hs-toggle-hiding)
                (error t))
              (hs-show-all))
        (toggle-selective-display column)))

(global-set-key (kbd "C-+") 'toggle-hiding)
(global-set-key (kbd "C-\\") 'toggle-selective-display)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-image-file-mode t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(global-font-lock-mode t)
 '(indicate-empty-lines t)
 '(show-paren-mode t)
 '(show-trailing-whitespace t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

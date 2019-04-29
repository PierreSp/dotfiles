(server-start)
(require 'org-protocol)
(with-eval-after-load 'org
  (add-to-list 'org-modules 'org-protocol))

(setq org-tag-alist (quote ((:startgroup)
                            ("@uni" . ?u)
                            ("@hainsfarth" . ?h)
                            ("@garching" . ?g)
                            ("@muenchen" . ?m)
                            (:endgroup)
                            ("WAITING" . ?w)
                            ("PERSONAL" . ?P)
                            ("WORK" . ?W)
                            ("ORG" . ?O)
                            ("NOTE" . ?n)
                            ("habit" .?h)
                            ("CANCELLED" . ?c)
                            ("FLAGGED" . ??))))

(setq org-fast-tag-selection-single-key (quote expert))

(setq org-agenda-files'(
                        "~/calendar.org"
                        "~/Projekte/org/uni_cal.org"
                        "~/Projekte/org/tasks.org"
                        "~/org/"
                        ))

(setq org-archive-tag "inactive")

;(setq org-agenda-tags-todo-honor-ignore-options t)

(setq org-agenda-start-on-weekday 1)

(setq org-agenda-span 1)

(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-filter-preset '("-someday"))
; Only show one recurring task
(setq org-agenda-show-future-repeats 'next)
; Hide dependent tasks (thanks to nathbo!)
(setq org-agenda-dim-blocked-tasks 'invisible)

(setq org-agenda-fontify-priorities
      (quote ((65 (:foreground "Red")) (66 (:foreground "Blue")) (67 (:foreground "Darkgreen")))))
(setq org-agenda-date-weekend (quote (:foreground "Yellow" :weight bold)))

(setq org-agenda-custom-commands
      ;; (append org-agenda-custom-commands
      '(("g" . "GTD-Workflow")
        ("gw" "Upcoming week" agenda ""
         ((org-agenda-span 'week)
          (org-agenda-filter-preset '("-habit"))
          (org-agenda-view-columns-initially t)
          ))
        ("gr" "Review past week" agenda
         ((org-agenda-span 'week)
          (org-agenda-skip-scheduled-if-done nil)
          (org-agenda-log-mode)
          ))

        ("n" "Next Actions"
         ((todo "TODO"
                ((org-agenda-filter-preset '("-someday"))
                 (org-agenda-todo-ignore-scheduled t)
                 (org-deadline-warning-days 90)))
          (tags-todo "habit")
          (agenda ""
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-span 1)
                   (org-deadline-warning-days 90)
                   (org-agenda-time-grid nil)
                   (org-agenda-overriding-header "Upcoming Deadlines")
                   ))
          ))

        ;; Special types
        ("s" "Someday" tags "someday"
         ((org-agenda-filter-preset '("+someday"))
          (org-use-tag-inheritance nil)
          (org-agenda-todo-ignore-with-date nil)))

        ;; Contexts
        ("h" "@Home"
         ((tags "@HOME"
                ((org-agenda-todo-ignore-with-date nil)))
          ))
        ("u" "@Uni"
         ((tags "@UNI"
                ((org-agenda-todo-ignore-with-date nil)))
          ))
        ("m" "master" tags "masterthesis"
         ((org-agenda-todo-ignore-with-date nil))
         )

        ("d" "Upcoming deadlines" agenda ""
         ((org-agenda-entry-types '(:deadline))
          (org-agenda-span 1)
          (org-deadline-warning-days 120)
          (org-agenda-overriding-header "Upcoming Deadlines")
          (org-agenda-time-grid nil)))

        )
      )

(setq org-capture-templates
      '(("t" "Aufgabe in tasks.org" entry (file+headline "~/Projekte/org/tasks.org" "Inbox")
         "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
        ("m" "Aufgabe aus Mail" entry (file+headline "~/Projekte/org/tasks.org" "Inbox")
         "* TODO %? , Link: %a")
        ("c" "Cookbook" entry (file "~/org/cookbook.org")
         "%(org-chef-get-recipe-from-url)" :empty-lines 1)
        ("p" "Phone call" entry (file "~/Projekte/org/tasks.org" "Inbox")
         "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
        ("g" "Add normal entry to google calendar" entry
         (file "~/calendar.org")
         "* %?
 %^T" :empty-lines 1 :empty-lines-after 1 :time-prompt t)

        ("m" "Masterarbeit")
        ("mq" "Masterarbeit: Question" entry (file+headline "~/org/mt_general.org" "Open Questions")
         "- %?")
        ("mt" "Masterarbeit: ToDo" entry (file+headline "~/org/mt_general.org" "Todo")
         "* TODO %?")
        ("mg" "Masterarbeit: General" entry (file+olp "~/org/mt_general.org" "General")
         "* %?")
        ))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq reftex-default-bibliography '("~/UNI/papers/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/UNI/papers/notes.org"
      org-ref-default-bibliography '("~/UNI/papers/references.bib")
      org-ref-pdf-directory "~/UNI/papers/bibtex-pdfs/")

;; Further variables for helm-bibtex
(setq bibtex-completion-bibliography "~/UNI/papers/references.bib"
      bibtex-completion-library-path "~/UNI/papers/bibtex-pdfs"
      bibtex-completion-notes-path "~/UNI/papers/helm-bibtex-notes")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)
;; Download directory
(setq biblio-download-directory "~/UNI/papers/bibtex-pdfs")

;; This works when using emacs --daemon + emacsclient
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
;; This works when using emacs without server/client
(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")

(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
            `(,(car regex-char-pair)
              (0 (prog1 ()
                   (compose-region (match-beginning 1)
                                   (match-end 1)
                                   ;; The first argument to concat is a string containing a literal tab
                                   ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
          '(("\\(www\\)"                   #Xe100)
            ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
            ("\\(\\*\\*\\*\\)"             #Xe102)
            ("\\(\\*\\*/\\)"               #Xe103)
            ("\\(\\*>\\)"                  #Xe104)
            ("[^*]\\(\\*/\\)"              #Xe105)
            ("\\(\\\\\\\\\\)"              #Xe106)
            ("\\(\\\\\\\\\\\\\\)"          #Xe107)
            ("\\({-\\)"                    #Xe108)
            ;; ("\\(\\[\\]\\)"                #Xe109) This is the [] ligature and I don't like
            ("\\(::\\)"                    #Xe10a)
            ("\\(:::\\)"                   #Xe10b)
            ("[^=]\\(:=\\)"                #Xe10c)
            ("\\(!!\\)"                    #Xe10d)
            ("\\(!=\\)"                    #Xe10e)
            ("\\(!==\\)"                   #Xe10f)
            ("\\(-}\\)"                    #Xe110)
            ("\\(--\\)"                    #Xe111)
            ("\\(---\\)"                   #Xe112)
            ("\\(-->\\)"                   #Xe113)
            ("[^-]\\(->\\)"                #Xe114)
            ("\\(->>\\)"                   #Xe115)
            ("\\(-<\\)"                    #Xe116)
            ("\\(-<<\\)"                   #Xe117)
            ("\\(-~\\)"                    #Xe118)
            ("\\(#{\\)"                    #Xe119)
            ("\\(#\\[\\)"                  #Xe11a)
            ("\\(##\\)"                    #Xe11b)
            ("\\(###\\)"                   #Xe11c)
            ("\\(####\\)"                  #Xe11d)
            ("\\(#(\\)"                    #Xe11e)
            ("\\(#\\?\\)"                  #Xe11f)
            ("\\(#_\\)"                    #Xe120)
            ("\\(#_(\\)"                   #Xe121)
            ("\\(\\.-\\)"                  #Xe122)
            ("\\(\\.=\\)"                  #Xe123)
            ("\\(\\.\\.\\)"                #Xe124)
            ("\\(\\.\\.<\\)"               #Xe125)
            ("\\(\\.\\.\\.\\)"             #Xe126)
            ("\\(\\?=\\)"                  #Xe127)
            ("\\(\\?\\?\\)"                #Xe128)
            ("\\(;;\\)"                    #Xe129)
            ("\\(/\\*\\)"                  #Xe12a)
            ("\\(/\\*\\*\\)"               #Xe12b)
            ("\\(/=\\)"                    #Xe12c)
            ("\\(/==\\)"                   #Xe12d)
            ("\\(/>\\)"                    #Xe12e)
            ("\\(//\\)"                    #Xe12f)
            ("\\(///\\)"                   #Xe130)
            ("\\(&&\\)"                    #Xe131)
            ("\\(||\\)"                    #Xe132)
            ("\\(||=\\)"                   #Xe133)
            ;("[^|]\\(|=\\)"                #Xe134)
            ("\\(|>\\)"                    #Xe135)
            ("\\(\\^=\\)"                  #Xe136)
            ("\\(\\$>\\)"                  #Xe137)
            ("\\(\\+\\+\\)"                #Xe138)
            ("\\(\\+\\+\\+\\)"             #Xe139)
            ("\\(\\+>\\)"                  #Xe13a)
            ("\\(=:=\\)"                   #Xe13b)
            ;("[^!/]\\(==\\)[^>]"           #Xe13c)
            ("\\(===\\)"                   #Xe13d)
            ("\\(==>\\)"                   #Xe13e)
            ;("[^=]\\(=>\\)"                #Xe13f)
            ("\\(=>>\\)"                   #Xe140)
            ("\\(<=\\)"                    #Xe141)
            ("\\(=<<\\)"                   #Xe142)
            ("\\(=/=\\)"                   #Xe143)
            ("\\(>-\\)"                    #Xe144)
            ("\\(>=\\)"                    #Xe145)
            ("\\(>=>\\)"                   #Xe146)
            ("[^-=]\\(>>\\)"               #Xe147)
            ("\\(>>-\\)"                   #Xe148)
            ("\\(>>=\\)"                   #Xe149)
            ("\\(>>>\\)"                   #Xe14a)
            ("\\(<\\*\\)"                  #Xe14b)
            ("\\(<\\*>\\)"                 #Xe14c)
            ("\\(<|\\)"                    #Xe14d)
            ("\\(<|>\\)"                   #Xe14e)
            ("\\(<\\$\\)"                  #Xe14f)
            ("\\(<\\$>\\)"                 #Xe150)
            ("\\(<!--\\)"                  #Xe151)
            ("\\(<-\\)"                    #Xe152)
            ("\\(<--\\)"                   #Xe153)
            ("\\(<->\\)"                   #Xe154)
            ("\\(<\\+\\)"                  #Xe155)
            ("\\(<\\+>\\)"                 #Xe156)
            ("\\(<=\\)"                    #Xe157)
            ("\\(<==\\)"                   #Xe158)
            ("\\(<=>\\)"                   #Xe159)
            ("\\(<=<\\)"                   #Xe15a)
            ("\\(<>\\)"                    #Xe15b)
            ("[^-=]\\(<<\\)"               #Xe15c)
            ("\\(<<-\\)"                   #Xe15d)
            ("\\(<<=\\)"                   #Xe15e)
            ("\\(<<<\\)"                   #Xe15f)
            ("\\(<~\\)"                    #Xe160)
            ("\\(<~~\\)"                   #Xe161)
            ("\\(</\\)"                    #Xe162)
            ("\\(</>\\)"                   #Xe163)
            ("\\(~@\\)"                    #Xe164)
            ("\\(~-\\)"                    #Xe165)
            ("\\(~=\\)"                    #Xe166)
            ("\\(~>\\)"                    #Xe167)
            ("[^<]\\(~~\\)"                #Xe168)
            ("\\(~~>\\)"                   #Xe169)
            ("\\(%%\\)"                    #Xe16a)
            ;; ("\\(x\\)"                   #Xe16b) This ended up being hard to do properly so i'm leaving it out.
            ("[^:=]\\(:\\)[^:=]"           #Xe16c)
            ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
            ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f)
            )))

(defun add-fira-code-symbol-keywords ()
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

(add-hook 'prog-mode-hook
          #'add-fira-code-symbol-keywords)

(global-set-key (kbd "C-S-c") 'evil-commentary-line)

(define-key global-map (kbd "<f1>") 'neotree)
(setq neo-theme 'icons)

(global-set-key "\M-j" 'hippie-expand)

(evil-leader/set-key-for-mode 'org-mode "I" 'interleave-mode)
(evil-leader/set-key-for-mode 'org-mode "B" 'helm-bibtex)
(evil-leader/set-key-for-mode 'bibtex-mode "B" 'helm-bibtex)

(with-eval-after-load 'org
  (evil-define-key '(normal insert) org-mode-map (kbd "M-RET M-RET") 'org-meta-return))

(fset 'my-clock-in "\C-c\C-x\C-i")
(global-set-key (kbd "<f5>") 'my-clock-in)

(fset 'my-clock-out "\C-c\C-x\C-o")
(global-set-key (kbd "<f8>") 'my-clock-out)

(defun save-all () (interactive) (save-some-buffers t))
(global-set-key (kbd "C-s") 'save-all)

(setq alert-default-style 'libnotify)

(setq-default pdf-view-display-size 'fit-page)

(setq org-gcal-file-alist '(("pspri99@gmail.com" . "~/calendar.org")
                        ("h8raedgh2c8hoa7fk49v8aogmc0ldbda@import.calendar.google.com" . "~/Projekte/org/uni_cal.org")
                            ))

  (defun read-lines (filePath)
    "Return a list of lines of a file at filePath."
    (with-temp-buffer
      (insert-file-contents filePath)
      (split-string (buffer-string) "\n" t)))
  (setq auth-lines (read-lines "~/gcal.auth"))
  (setq org-gcal-client-id (car auth-lines)
       org-gcal-client-secret (car (cdr auth-lines)))

(add-hook 'org-capture-after-finalize-hook 'google-calendar/sync-cal-after-capture)

(setq scroll-margin 5)

(spacemacs/toggle-truncate-lines-on)

(add-hook 'text-mode-hook 'spacemacs/toggle-visual-line-navigation-on)

(cua-mode 1)

(setq calendar-location-name "Munich, Germany")
(setq calendar-latitude 48.248872)
(setq calendar-longitude 11.653248)

(setq sunshine-appid "4fba292d761a7cb80a8aec91fd6d522b")
(setq sunshine-location "85748,DE")
(setq sunshine-units 'metric)
(setq sunshine-show-icons t)

(setq
 desktop-dirname             "~/.emacs.d/session/"
 desktop-path                (list desktop-dirname)
 desktop-auto-save-timeout 5
 desktop-restore-eager 5) ;; lazily restore desktop buffers
(desktop-save-mode 1)

;; add before `desktop-read' hook
(defvar desktop-before-read-hook '() "Hooks run before `desktop-read'.")
(defadvice desktop-read (before my:desktop-read-run-before-hooks activate)
  (run-hooks 'desktop-before-read-hook))
(setq undo-tree-auto-save-history t)
(defun my:enable-global-undo-tree()
  (global-undo-tree-mode 1)
  (diminish 'undo-tree-mode))
(add-hook 'desktop-before-read-hook 'my:enable-global-undo-tree)

(add-to-list 'org-modules 'org-habit)

(setq evil-want-fine-undo t)

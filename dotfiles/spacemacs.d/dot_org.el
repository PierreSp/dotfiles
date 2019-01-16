;;;; General org config file

;;;;;;;;;;;;;;;;ORG CONFIG

;; allow inline images
(setq org-display-inline-images t)
;;  (setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images t)
;; Save everything at autosave
(add-hook 'auto-save-hook 'org-save-all-org-buffers)
   (server-start)
  (require 'org-protocol)
  (with-eval-after-load 'org
    (add-to-list 'org-modules 'org-protocol))

  (setq org-agenda-files'(
      "~/calendar.org"
      "~/Projekte/org/uni_cal.org"
      "~/Projekte/org/tasks.org"
      "~/org/"
      ))
  (setq org-capture-templates
        '(("t" "Aufgabe in tasks.org" entry (file+headline "~/Projekte/org/tasks.org" "Inbox")
           "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
          ("w" "Waiting For Reply (Mail)" entry (file+headline "~/Projekte/org/tasks.org" "Inbox")
           "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
          ("m" "Aufgabe aus Mail" entry (file+headline "~/Projekte/org/tasks.org" "Inbox")
           "* TODO %? , Link: %a")
          ("p" "Phone call" entry (file "~/Projekte/org/tasks.org" "Inbox")
           "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
      ("g" "Google cal" entry
       (file "~/calendar.org")
       "* %? - %a
 %^T" :empty-lines 1 :empty-lines-after 1 :time-prompt t)
      ("c" "Add normal entry to google calendar" entry
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
                                        ; Tags with fast selection keys
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

                                        ; Allow setting single tags without the menu
        (setq org-fast-tag-selection-single-key (quote expert))

;; Custom todo keys
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
;; Set tags when switching different states of todo
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;;;;Google calendar functions and org ref settings


;; Google Calendar
;; Nice way to get cal auth data (thanks to nathanael)
;; Read lines from gcal.auth and store them in the variable
;; Function to read lines of a file and output a list
(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))
(setq auth-lines (read-lines "~/gcal.auth"))

(setq org-gcal-client-id (car auth-lines)
      org-gcal-client-secret (car (cdr auth-lines)))
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
;; Hotkeys - thanks to nathbo
(evil-leader/set-key-for-mode 'org-mode "I" 'interleave-mode)
(evil-leader/set-key-for-mode 'org-mode "B" 'helm-bibtex)
(evil-leader/set-key-for-mode 'bibtex-mode "B" 'helm-bibtex)
;; Org mode keybinding
(with-eval-after-load 'org
  (evil-define-key '(normal insert) org-mode-map (kbd "M-RET M-RET") 'org-meta-return))

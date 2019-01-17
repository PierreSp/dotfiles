;; Allow many clocks
(setq org-clock-history-length 95)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Include running clocks in report:
(setq org-clock-report-include-clocking-task t)
;;this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)
;; Activate clock in bar
(setq mode-line-org-clock t)
;; Log when done
(setq org-log-done 'time)
;; use pretty things for the clocktable
(setq org-pretty-entities t)
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;; Set default column view headings: Task Priority Effort Clock_Summary
(setq org-columns-default-format "%50ITEM(Task) %2PRIORITY %10Effort(Effort){:} %10CLOCKSUM")
;; Agenda log mode items to display (closed and state changes by default)
(setq org-agenda-log-mode-items (quote (closed state)))
;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)))
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1 )))


;; activate clock
(spacemacs/toggle-mode-line-org-clock-on)
;; Save the running clock and all clock history when exiting Emacs,
;; Clock out when exiting emacs
;; (setq org-clock-persist t)
(add-hook 'kill-emacs-hook #'org-clock-out)

;; Use f5 and f8 for clocks
(fset 'my-clock-in "\C-c\C-x\C-i")
(global-set-key (kbd "<f5>") 'my-clock-in)

(fset 'my-clock-out "\C-c\C-x\C-o")
(global-set-key (kbd "<f8>") 'my-clock-out)
;; Show priorites:
(setq org-agenda-fontify-priorities
      (quote ((65 (:foreground "Red")) (66 (:foreground "Blue")) (67 (:foreground "Darkgreen")))))
(setq org-agenda-date-weekend (quote (:foreground "Yellow" :weight bold)))

;; Do not show tasks which are done:
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
;; Make main calendar to calendar.org and define it as agenda file
(setq org-gcal-file-alist '(("pspri99@gmail.com" . "~/calendar.org")
                            ("h8raedgh2c8hoa7fk49v8aogmc0ldbda@import.calendar.google.com" . "~/Projekte/org/uni_cal.org")
                            ))
(setq org-archive-tag "inactive")
                                        ; For tag searches ignore tasks with scheduled and deadline dates
(setq org-agenda-tags-todo-honor-ignore-options t)
;; Start week on monday
(setq org-agenda-start-on-weekday 1)
;; start agenda in day mode
(setq org-agenda-span 1)
;; start with someday and filters - thanks to nathbo
(setq org-agenda-filter-preset '("-someday"))
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

        ("d" "Upcoming deadlines" agenda ""
         ((org-agenda-entry-types '(:deadline))
          (org-agenda-span 1)
          (org-deadline-warning-days 60)
          (org-agenda-overriding-header "Upcoming Deadlines")
          (org-agenda-time-grid nil)))

        )
      )

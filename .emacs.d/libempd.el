;;; libempd.el --- library for dealing with MPD (Music Player Daemon)

;; Copyright (C) 2004-2005 Mikhail Gusarov <dottedmag@gorodok.net>
;;
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

; Handlers queue is the queue of server response handlers. This queue
; is manipulated by the 'empd-add-handler' function and by the
; handlers return value (see below).
;
; Handler is the function receiving lines from the network
; stream. Line is the string with terminating '\n' and without '\n'
; inside. To indicate finish of processing you need to return symbol
; `finished' from the handler.  This will remove handler from the
; queue and the following input will be passed to the next handler or
; will generate an error if no handlers remain in the queue.

(defvar empd-handlers-queue '(nil))
(defvar empd-handlers-queue-insert-pos
  empd-handlers-queue)

(defvar empd-unprocessed-string "")

(defun empd-handle-line (string)
  (if (car empd-handlers-queue)
	  (if (eq 'finished (funcall (car empd-handlers-queue) string))
			(setq empd-handlers-queue
				  (cdr empd-handlers-queue)))
	(message "Empty handlers-queue")))

(defun empd-handler (process string)
  (empd-log-incoming string)
  (setq empd-unprocessed-string (concat empd-unprocessed-string string))
  (while (string-match "\n" empd-unprocessed-string)
	(let* ((line-end (string-match "\n" empd-unprocessed-string))
		   (line (substring empd-unprocessed-string 0 line-end)))
	  (setq empd-unprocessed-string (substring empd-unprocessed-string (1+ line-end)))
	  (empd-handle-line line))))


(defun empd-add-handler (handler)
  (setcar empd-handlers-queue-insert-pos handler)
  (setq empd-handlers-queue-insert-pos
		(setcdr empd-handlers-queue-insert-pos (cons nil nil))))

;;;;;;;;;;;;;;

(defun empd-log (prefix string)
  (with-current-buffer (get-buffer-create "*MPD-LOG*")
	(mapcar `(lambda (string) (insert ,prefix string "\n")) 
			(split-string string "\n"))))

(defun empd-log-incoming (string)
  (empd-log ">" string))

(defun empd-log-outgoing (string)
  (empd-log "<" string))

(defun empd-log-info (string)
  (empd-log "=" string))

(defvar empd-connection nil)

(defvar empd-hostname "localhost")
(defvar empd-port "6600")

(defun empd-execute-command (command handler)
  (if (or (not (processp empd-connection))
		  (not (eq (process-status empd-connection) 'open)))
	  (setq empd-connection (empd-open-connection empd-hostname empd-port)))
  (empd-add-handler handler)
  (empd-log-outgoing command)
  (process-send-string empd-connection command))

(defun empd-open-connection (host port)
  (empd-log-info (format "Opening connection to %s:%d" host port))
  (setq empd-handlers-queue '(nil))
  (setq empd-handlers-queue-insert-pos empd-handlers-queue)
  (empd-add-handler 'empd-read-banner-handler)
  (setq empd-connection (open-network-stream "*mpd*" nil host port))
  (set-process-coding-system empd-connection 'utf-8)
  (set-process-filter empd-connection 'empd-handler)
  empd-connection)

(defun empd-close-connection ()
  (empd-log-info "Closing connection")
  (if (and (processp empd-connection)
		   (eq (process-status empd-connection) 'open))
	  (delete-process empd-connection))
  (setq empd-connection nil))

(defun empd-read-banner-handler (string)
  (if (string-match "^OK " string)
	  (message (substring string 3)))
  'finished)

(defun empd-discard-ok-handler (string)
  'finished)

(defun empd-print-handler (string)
  (if (string-match "^OK" string)
	  'finished
	nil))

;
; Result-catcher is the analog of 'catch/finally' clauses.
; If the server returned 'OK' on the line itself, it will be invoked
; with 'ok symbol as the argument. If the server returned 'ACK <string>',
; this string will be passed to the result-catcher.
; Both results remove handler from the queue.
;
; For each line, except ACK and OK, handler will be invoked.
;

(defun empd-make-handler (handler result-catcher)
  `(lambda (string)
	 (cond
	  ((string-match "^OK" string) (,result-catcher 'ok) 'finished)
	  ((string-match "^ACK " string) (,result-catcher (substring 4 string)) 'finished)
	  (t (,handler string) nil))))

(defun ignore-error (code))

;;;;;;;;;;;;;;

(defun empd->pause (param)
  (empd-execute-command (concat "pause " param "\n") 'empd-print-handler))

(defun empd->play (song)
  (empd-execute-command (concat "play " song "\n") 'empd-print-handler))

(defun empd->stop ()
  (empd-execute-command "stop\n" 'empd-print-handler))

(defun empd->ping ()
  (empd-execute-command "ping\n" 'empd-print-handler))

(defun empd->listall (handler)
  (empd-execute-command "listall\n" (empd-make-handler handler 'ignore-error)))

(defun empd->add (file)
  (empd-execute-command (concat "add " file "\n") 'empd-read-banner-handler))

(defun empd->status (handler)
  (let ((empd-handler
		 (empd-make-handler
		  `(lambda (info-line)
			 (let ((split-line (split-string info-line ": ")))
			   (,handler (car split-line) (cadr split-line)))) 'ignore-error)))
	(empd-execute-command "status\n" empd-handler)))

;;;;;;;;;;;;;;;

(provide 'libempd)

;;; libempd.el ends here

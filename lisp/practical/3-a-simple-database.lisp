;;;;"A Simple Database"
;;;;
;;;; This program is an attempt to write a simple database in Common
;;;; Lisp, specifically in SBCL (Steel Bank Common Lisp).  It is a
;;;; part of the "Practical Common Lisp" book and its series of
;;;; exercises.
;;;;
;;;; I'm using these for purely personal purposes, but since they're
;;;; going to end up in a repo somewhere anyway, here's a license:
;;;;
;;
;; Copyright (c) 2016, John "edt" Markiewicz <jmarkiewicz@airmail.cc>
;;
;; All rights reserved.  Redistribution and use in source and binary
;; forms, with or without modification, are permitted provided that
;; the following conditions are met:
;;
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;;
;; 2. Redistributions in binary form must reproduce the above
;;    copyright notice, this list of conditions and the following
;;    disclaimer in the documentation and/or other materials provided
;;    with the distribution.
;;
;; 3. Neither the name of the copyright holder nor the names of its
;;    contributors may be used to endorse or promote products derived
;;    from this software without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
;; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.
;;
;;;; Anyway, with that formality out of the way, enjoy the code!
;;;;
;;;; ...
;;;;
;;;; Why are you reading this code, again?

(defun make-cd (title artist rating ripped runtime)
  "Make a CD with the properties (title artist rating ripped runtime)."
  (list :title title :artist artist :rating rating :ripped ripped :runtime runtime))

(defvar *db* nil)

(defun add-cd (cd)
  (push cd *db*))

(defun file-cd (title artist rating ripped runtime)
  (add-cd (make-cd title artist rating ripped runtime)))

(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%"
	    cd)))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun cd-prompt ()
  (file-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]: ")
   (prompt-read "Runtime")))

(defun save-db (filename)
  (with-open-file (out filename
		       :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(defun select (selector-fn)
  (remove-if-not selector-fn *db*))

(defun artist-selector (artist)
  #'(lambda (cd) (equal (getf cd :artist) artist)))

;; (defun where (&key title artist rating (ripped nil ripped-p) runtime)
;;   #'(lambda (cd)
;;       (and
;;        (if title
;; 	   (equal (getf cd :title) title) t)
;;        (if artist
;; 	   (equal (getf cd :artist) artist) t)
;;        (if rating
;; 	   (equal (getf cd :rating) rating) t)
;;        (if ripped-p
;; 	   (equal (getf cd :ripped) ripped) t))))

;;; alternately, you could do this:
(defun make-comparison-expr (field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparison-list (fields)
  (loop while fields
     collecting (make-comparison-expr (pop fields) (pop fields))))

(defmacro where (&rest clauses)
  `#'(lambda (row) (and ,@ (make-comparison-list clauses))))
;;; much cleaner, isn't it?
;;; do this thing  instead.

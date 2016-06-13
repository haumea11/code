;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(defun insert-decorative-lines ()
  (insert (format "+------------------------------------------------------------------------------+")
	  (format "| ============================================================================ |")
	  (format "+------------------------------------------------------------------------------+")))

(define-minor-mode eastern-daylight-mode
  "A custom mode to do the things I think I want a mode to do.
   
   I don't know how much use this is, but I think it's cool."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " EDM"
  ;; The minor mode bindings.
  '(([M-p] . insert-decorative-lines))
  :group 'edt)



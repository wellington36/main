#lang sicp

(define count-pairs
  (let ((visited-pairs nil))
    (lambda (x)
      (if (pair? x)
	  (if (memq x visited-pairs)
	      0
	      (begin (set! visited-pairs (cons x visited-pairs))
		     (+ (count-pairs (car x))
			(count-pairs (cdr x))
			1)))
	  0))))

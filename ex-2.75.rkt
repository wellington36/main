#lang racket

(require rackunit)

(define (make-from-mag-ang x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* x (cos y)))
          ((eq? op 'imag-part) (* x (sin y)))
          ((eq? op 'magnitude) x)
          ((eq? op 'angle) y)
          (else
           (error "Unknown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)

(check-equal? ((make-from-mag-ang 1 (/ pi 3)) 'real-part) (* 1 (cos (/ pi 3))))
(check-equal? ((make-from-mag-ang 1 pi) 'magnitude) 1)

(provide make-from-mag-ang)

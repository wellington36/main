#lang racket

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  
  (define (try guess)
    (display guess) (display " ")
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next)))))

(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))

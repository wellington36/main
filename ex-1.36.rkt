#lang racket

(define tolerance 0.00001)
(define (average n m)
  (/ (+ n m) 2))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (display guess) (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;; 55 chutes
(fixed-point (lambda (x) (/ (log 100) (log x))) 2)

;; 9 chutes
(fixed-point (lambda (x) (average x (/ (log 100) (log x)))) 2)


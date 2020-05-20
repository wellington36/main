#lang racket

(require "ex-2.75.rkt")
(require rackunit)
  
(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

;testes

(check-equal? (real-part (add-complex (make-from-real-imag 1 2) (make-from-real-imag 3 -2))) 4)
(check-equal? (real-part (sub-complex (make-from-real-imag 1 2) (make-from-real-imag 3 -2))) -2)
(check-equal? (magnitude (mul-complex (make-from-mag-ang 1 2) (make-from-mag-ang 3 -2))) 3)
(check-equal? (magnitude (div-complex (make-from-mag-ang 1 2) (make-from-mag-ang 3 -2))) 1/3)
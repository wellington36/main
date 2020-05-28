#lang racket

;; provide the put and get

(require "table.rkt" "tag-system.rkt" "complex-ben.rkt" "complex-alyssa.rkt")

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z)     (apply-generic 'angle z))

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))


(provide real-part imag-part magnitude angle
         make-from-real-imag make-from-mag-ang)


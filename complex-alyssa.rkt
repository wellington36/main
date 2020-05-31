#lang racket

(require "table.rkt" "tag-system.rkt" "utils.rkt")

(define (real-part z)
  (* (magnitude z) (cos (angle z))))

(define (imag-part z)
  (* (magnitude z) (sin (angle z))))

(define (magnitude z) (car z))

(define (angle z) (cdr z))

(define (make-from-real-imag x y) 
  (cons (sqrt (+ (square x) (square y)))
        (atan y x)))

(define (make-from-mag-ang r a)
  (cons r a))

(define (tag x) (attach-tag 'polar x))

(put 'real-part '(polar) real-part)
(put 'imag-part '(polar) imag-part)
(put 'magnitude '(polar) magnitude)
(put 'angle '(polar) angle)

(put 'make-from-real-imag 'polar
     (lambda (x y) (tag (make-from-real-imag x y))))

(put 'make-from-mag-ang 'polar 
     (lambda (r a) (tag (make-from-mag-ang r a))))



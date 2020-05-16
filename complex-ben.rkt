#lang racket

(require "table.rkt")
(require "tag-system.rkt")
(require "utils.rkt")

(define (real-part z)
  (car z))

(define (imag-part z)
  (cdr z))

(define (magnitude z)
  (sqrt (+ (square (real-part z))
           (square (imag-part z)))))

(define (angle z)
  (atan (imag-part z)
        (real-part z)))

(define (make-from-real-imag x y)
  (cons x y))

(define (make-from-mag-ang r a) 
  (cons (* r (cos a)) (* r (sin a))))


(define (tag x) (attach-tag 'rectangular x))

(put 'real-part '(rectangular) real-part)
(put 'imag-part '(rectangular) imag-part)
(put 'magnitude '(rectangular) magnitude)
(put 'angle '(rectangular) angle)

(put 'make-from-real-imag 'rectangular 
     (lambda (x y) (tag (make-from-real-imag x y))))

(put 'make-from-mag-ang 'rectangular 
     (lambda (r a) (tag (make-from-mag-ang r a))))



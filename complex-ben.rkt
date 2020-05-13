#lang racket

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
  (attach-tag 'rectangular (cons x y)))

(define (make-from-mag-ang r a) 
  (attach-tag 'rectangular
              (cons (* r (cos a)) (* r (sin a)))))


(provide real-part imag-part
         magnitude angle
         make-from-real-imag make-from-mag-ang)

#lang racket

(require "tag-system.rkt")
(require "utils.rkt")

(define (real-part z)
  (* (magnitude z) (cos (angle z))))

(define (imag-part z)
  (* (magnitude z) (sin (angle z))))

(define (magnitude z) (car z))

(define (angle z) (cdr z))

(define (make-from-real-imag x y) 
  (attach-tag 'polar
               (cons (sqrt (+ (square x) (square y)))
                     (atan y x))))

(define (make-from-mag-ang r a)
  (attach-tag 'polar (cons r a)))


(provide real-part imag-part
         magnitude angle
         make-from-real-imag make-from-mag-ang)

#lang racket

(require "tag-system.rkt")
(require (prefix-in rect: "complex-ben.rkt"))
(require (prefix-in pola: "complex-alyssa.rkt"))
;; (require "complex-ben.rkt")
;; (require "complex-alyssa.rkt")

(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z)
  (eq? (type-tag z) 'polar))

(define (real-part z)
  (cond ((rectangular? z) 
         (rect:real-part (contents z)))
        ((polar? z)
         (pola:real-part (contents z)))
        (else (error "Unknown type -- REAL-PART" z))))

(define (imag-part z)
  (cond ((rectangular? z)
         (rect:imag-part (contents z)))
        ((polar? z)
         (pola:imag-part (contents z)))
        (else (error "Unknown type -- IMAG-PART" z))))

(define (magnitude z)
  (cond ((rectangular? z)
         (rect:magnitude (contents z)))
        ((polar? z)
         (pola:magnitude (contents z)))
        (else (error "Unknown type -- MAGNITUDE" z))))

(define (angle z)
  (cond ((rectangular? z)
         (rect:angle (contents z)))
        ((polar? z)
         (pola:angle (contents z)))
        (else (error "Unknown type -- ANGLE" z))))


(define (make-from-real-imag x y)
  (rect:make-from-real-imag x y))

(define (make-from-mag-ang r a)
  (pola:make-from-mag-ang r a))


(provide real-part imag-part
         magnitude angle
         make-from-real-imag make-from-mag-ang)

#lang racket

;; In other words, make-rat, numer, and denom must satisfy the condition that,
;; for any integer n and any non-zero integer d, if x is (make-rat n d)
;; (numer x) / (denom x) = n/d

;; That is, the operations satisfy the condition that, for any objects x and y,
;; if z is (cons x y) then (car z) is x and (cdr z) is y

(define (cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- CONS" m))))
  dispatch)

(define (car z) (z 0))

(define (cdr z) (z 1))


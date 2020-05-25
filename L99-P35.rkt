#lang racket

(require "prime.rkt")
(require rackunit)

(define (prime-factors n)
  (define (iter aux1 aux2)
    (cond ((> aux1 aux2)
           empty)
          ((and (prime? aux1) (= (remainder aux2 aux1) 0))
          (cons aux1 (iter aux1 (/ aux2 aux1))))
          (else (iter (+ aux1 1) aux2))))
  (iter 2 n))

(check-equal? (prime-factors 315) '(3 3 5 7))
(check-equal? (prime-factors 1024) '(2 2 2 2 2 2 2 2 2 2))
(check-equal? (prime-factors 321398) '(2 7 11 2087))
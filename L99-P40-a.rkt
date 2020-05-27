#lang racket

(require rackunit)
(require "L99-P39.rkt")

;Goldbach's conjecture says that every positive even number greater than 2 is the sum of two prime numbers.
;Write a predicate to find the two prime numbers that sum up to a given even integer.

;Example:
;(goldbach 28)
;(5 23)

(define (goldbach number)
  (let ([lst (lst-of-prime 0 number)])
    (define (goldbach-iter lst-1 lst-2)
      (cond ((null? lst) '())
            ((null? lst-2) (goldbach-iter (cdr lst-1) lst))
            ((= (+ (car lst-1) (car lst-2)) number) (list (car lst-1) (car lst-2)))
            (else (goldbach-iter lst-1 (cdr lst-2)))))
  (goldbach-iter lst lst)))

(check-equal? (goldbach 28) '(5 23))
(check-equal? (goldbach 10) '(3 7))
(check-equal? (goldbach -10) '())
(check-equal? (goldbach 0) '())

(provide goldbach)



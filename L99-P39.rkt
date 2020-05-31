#lang racket

(require rackunit)

(require "prime.rkt")

(define (lst-of-prime lower upper)
  (filter (λ (x) (and (prime? x) (> x 1)))
          (range (+ lower 1) upper)))

(check-equal? (lst-of-prime 2 20) '(3 5 7 11 13 17 19))
(check-equal? (lst-of-prime -20 2) '())
(check-equal? (lst-of-prime 3 3) '())
(check-equal? (lst-of-prime 10 2) '())

(provide lst-of-prime)


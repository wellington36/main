#lang racket

(require "prime.rkt")
(require rackunit)

(define (goldbach n)
  (let* ((p1 (random n))
         (p2 (- n p1)))
    (if (or (odd? n) (< n 3))
        (error "Enter an even number greater than 2")
        (if (and (prime? p1) (prime? p2) (not (= p1 1)) (not (= p2 1)))
            (if (> p1 p2)
                (list p2 p1)
                (list p1 p2))
            (goldbach n)))))


(check-equal? (apply + (goldbach 23129038)) 23129038)
(check-equal? (apply + (goldbach 28)) 28)
(check-equal? (apply + (goldbach 2293175120)) 2293175120)
  
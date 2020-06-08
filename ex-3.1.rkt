#lang racket

(require rackunit)

(define (make-accumulator value)
  (lambda (amount)
    (set! value (+ value amount))
    value))
        
(define A (make-accumulator 5))

(check-equal? (A 10) 15)

(check-equal? (A 10) 25)

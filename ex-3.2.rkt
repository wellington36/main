#lang racket

(require rackunit)

(define (make-monitored f) 
  (define number-of-calls 0) 
  (define (mf message) 
    (cond ((eq? message 'reset-count) (set! number-of-calls 0))
          ((eq? message 'how-many-calls?) number-of-calls) 
          (else (set! number-of-calls (+ number-of-calls 1)) 
                 (f message)))) 
  mf)

(define s (make-monitored sqrt))

(check-equal? (s 100) 10)
(check-equal? (s 'how-many-calls?) 1)

(provide make-monitored)




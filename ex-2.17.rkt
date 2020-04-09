#lang racket

(define (last-pair l)
  (cond ((empty? l)
         l)
        ((empty? (cdr l))
         l)
        (else
         (last-pair (cdr l)))))

(last-pair (list 23 72 149 34))
(last-pair '()) 

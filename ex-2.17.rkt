#lang racket

(define (last-pair l)
  (if (empty? (cdr l))
      l
      (last-pair (cdr l))))

(last-pair (list 23 72 149 34))
(last-pair '())

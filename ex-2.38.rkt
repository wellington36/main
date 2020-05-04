#lang racket

(require "2.34.rkt")

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (fold-right op in sequence)
  (accumulate op in sequence))

;(fold-right / 1 (list 1 2 3))
;(fold-left / 1 (list 1 2 3))
;(fold-right list null (list 1 2 3))
;(fold-left list null (list 1 2 3))

(provide fold-left fold-right)


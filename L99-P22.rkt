#lang racket

;; Create a list containing all integers within a given range.
;; If first argument is smaller than second, produce a list
;; in decreasing order.

(define (range a b)
  (cond ((= a b) (cons a empty))
        ((< a b)
         (cons a (range (+ a 1) b)))
        ((> a b)
         (cons a (range (- a 1) b)))))

(provide range)

;;test

(range 7 10)
(range 10 7)


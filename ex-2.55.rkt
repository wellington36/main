#lang racket

(define a (list 1 2))
(define b (list 1 2))

(define (memq item x)
  (cond ((empty? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(car ''alexandre)

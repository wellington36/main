#lang sicp

(define x (list 'a 'b))
;; (list 'a 'b) = (cons 'a (cons 'b nil))

(define z1 (cons x x))

(define z2 (cons (list 'a 'b) (list 'a 'b)))

(define (set-to-wow! x)
  (set-car! (car x) 'wow)
  x)


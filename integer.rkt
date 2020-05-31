#lang racket

(require "table.rkt" "tag-system.rkt")

(define (=zero? x)
  (= x 0)) ; ex-2.79

(define (tag x) (attach-tag 'integer x))

(put 'add '(integer integer)
     (lambda (x y) (tag (+ x y))))

(put 'sub '(integer integer)
     (lambda (x y) (tag (- x y))))

(put 'mul '(integer integer)
     (lambda (x y) (tag (* x y))))

(put 'div '(integer integer)
     (lambda (x y) (tag (/ x y))))

(put 'equ? '(integer integer)
     (lambda (x y) (tag (= x y))))

(put '=zero? '(integer)
     (lambda (x) (tag (=zero? x))))

(put 'make 'integer
     (lambda (x) (tag x)))

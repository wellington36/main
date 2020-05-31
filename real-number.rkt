#lang racket

(require "table.rkt" "tag-system.rkt")

(define (=zero? x)
  (= x 0)) ; ex-2.79

(define (tag x) (attach-tag 'real-number x))

(put 'add '(real-number real-number)
     (lambda (x y) (tag (+ x y))))

(put 'sub '(real-number real-number)
     (lambda (x y) (tag (- x y))))

(put 'mul '(real-number real-number)
     (lambda (x y) (tag (* x y))))

(put 'div '(real-number real-number)
     (lambda (x y) (tag (/ x y))))

(put 'equ? '(real-number real-number)
     (lambda (x y) (tag (= x y))))

(put '=zero? '(real-number)
     (lambda (x) (tag (=zero? x))))

(put 'make 'real-number
     (lambda (x) (tag x)))

#lang racket

(require rackunit)
(require "table.rkt")

(define (=zero? x)
  (= x 0)) ; ex-2.79

(put 'add    '(scheme-number scheme-number) +)
(put 'sub    '(scheme-number scheme-number) -)
(put 'mul    '(scheme-number scheme-number) *)
(put 'div    '(scheme-number scheme-number) /)
(put 'equ?   '(scheme-number scheme-number) =) ; ex-2.79
(put '=zero? '(scheme-number) =zero?) ; ex-2.80


;; test

(check-equal? (=zero? 10) ; ex-2.80
              false)
(check-equal? (=zero? 0) ; ex-2.79
              true)


#lang racket

(require rackunit)
(require "table.rkt")

(put 'add '(scheme-number scheme-number) +)
(put 'sub '(scheme-number scheme-number) -)
(put 'mul '(scheme-number scheme-number) *)
(put 'div '(scheme-number scheme-number) /)
(put 'equ? '(scheme-number scheme-number) =)

(define (=zero? x)
  (= x 0))

(put '=zero? '(scheme-number) =zero?)


;; test

(check-equal? (=zero? 10)
              false)
(check-equal? (=zero? 0)
              true)

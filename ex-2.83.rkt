#lang racket

(require "table.rkt" "tag-system.rkt" "integer.rkt" "rational.rkt"
         "real-number.rkt" "complex.rkt" rackunit)

(define (make-from-real-imag x y)
   ((get 'make-from-real-imag 'complex) x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(define (make-rational x y)
   ((get 'make 'rational) x y))

(define (make-integer x)
  ((get 'make 'integer) x))

(define (make-real-number x)
  ((get 'make 'real-number) x))

(define (numer r) (apply-generic 'numer r))
(define (denom r) (apply-generic 'denom r))

(define (real-number->complex x)
  (make-from-real-imag (contents x) 0))

(define (rational->real-number r)
  (make-real-number (/ (numer r) (denom r))))

(define (integer->rational x)
  (make-rational (contents x) 1))

(define (raise x)
  (cond ((eq? (type-tag x) 'integer)
         (integer->rational x))
        ((eq? (type-tag x) 'rational)
         (rational->real-number x))
        ((eq? (type-tag x) 'real-number)
         (real-number->complex x))
        ((eq? (type-tag x) 'complex)
         (error "HIGHEST POSSIBLE LEVEL"))))

;;testes

(define a (make-integer 2))
(define b (raise a))
(define c (raise b))
(define d (raise c))

(check-equal? b (make-rational 2 1))
(check-equal? c (make-real-number 2))
(check-equal? d (make-from-real-imag 2 0))
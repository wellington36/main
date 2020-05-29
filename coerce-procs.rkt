#lang racket

(require "table.rkt" "tag-system.rkt" "number.rkt" "complex.rkt"
	 "rational.rkt")
(require rackunit)

(define (make-from-real-imag x y)
   ((get 'make-from-real-imag 'complex) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))
(define (make-rational x y)
   ((get 'make 'rational) x y))

(define (numer r) (apply-generic 'numer r))
(define (denom r) (apply-generic 'denom r))

(define (scheme-number->complex x)
  (make-from-real-imag (contents x) 0))

(define (rational->scheme-number r)
  (/ (numer r) (denom r)))

(define (rational->complex r)
  (scheme-number->complex
   (rational->scheme-number r)))
                
(put-coercion 'scheme-number 'complex scheme-number->complex)
(put-coercion 'rational 'scheme-number rational->scheme-number)
(put-coercion 'rational 'complex rational->complex)

(check-equal? (rational->scheme-number (make-rational 1 2)) 1/2)
(check-equal? (scheme-number->complex 4) (make-from-real-imag 4 0))
(check-equal? (rational->complex (make-rational 1 2)) (make-from-real-imag 1/2 0))

(provide make-from-real-imag make-from-mag-ang make-rational numer denom)

#lang racket

(require "table.rkt")
(require "ex-2.78.rkt")
(require "number.rkt")
(require "complex-2.rkt")
(require "rational.rkt")
(require rackunit)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types -- APPLY-GENERIC"
           (list op type-tags))))))


(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))

(define (make-from-real-imag x y)
   ((get 'make-from-real-imag 'complex) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(define (make-rational x y)
   ((get 'make 'rational) x y))

; testes

(check-equal? (add 1 2) 3)

(check-equal? (mul (make-rational 1 2)
                   (make-rational 1 4))
              (make-rational 1 8))

(check-equal? (sub (make-from-real-imag 3 4)
                   (make-from-real-imag 5 4))
              (make-from-real-imag -2 0))

(check-equal? (add (make-from-real-imag 3 -5)
                   (make-from-real-imag 1 6))
              (make-from-real-imag 4 1))

(check-equal? (equ? (make-from-real-imag 3 -5)
                    (make-from-real-imag 1 6))
              #f)

(check-equal? (equ? (make-rational 3 5)
                    (make-rational 1 6))
              #f)

(check-equal? (equ? (make-rational 3 5)
                    (make-rational 6 10))
              #t)

(check-equal? (equ? 2 6) #f)
(check-equal? (=zero? 0) #t)
(check-equal? (=zero? (make-from-real-imag 3 -5)) #f)
(check-equal? (=zero? (make-rational 3 5)) #f)

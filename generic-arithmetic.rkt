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

;testes

(check-equal? (add 1 2) 3)
(check-equal? (mul (cons 'rational (cons 1 2)) (cons 'rational (cons 1 4)))
              '(rational 1 . 8))
(check-equal? (sub (cons 'complex (cons 'rectangular (cons 3 4)))
                   (cons 'complex (cons 'rectangular (cons 5 4))))
              '(complex rectangular -2 . 0))
(check-equal? (add '(complex rectangular 3 . -5)
                   '(complex rectangular 1 . 6))
              '(complex rectangular 4 . 1))
(check-equal? (equ? '(complex rectangular 3 . -5)
                    '(complex rectangular 1 . 6))
              #f)
(check-equal? (equ? '(rational 3 . 5)
                    '(rational 1 . 6))
              #f)
(check-equal? (equ? '(rational 3 . 5)
                    '(rational 6 . 10))
              #t)
(check-equal? (equ? 2 6) #f)
(check-equal? (=zero? 0) #t)
(check-equal? (=zero? '(complex rectangular 3 . -5)) #f)
(check-equal? (=zero? '(rational 3 . 5)) #f)


#lang racket

(require "table.rkt" "tag-system.rkt")

(require rackunit)

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equ? x y) ; ex-2.79
  (=(* (numer x) (denom y))
    (* (denom x) (numer y))))

(define (=zero? x) ; ex-2.80
  (= (numer x) 0))

;; interface to rest of the system
 
(define (tag x) (attach-tag 'rational x))

(put 'add '(rational rational)
     (lambda (x y) (tag (add-rat x y))))

(put 'sub '(rational rational)
     (lambda (x y) (tag (sub-rat x y))))

(put 'mul '(rational rational)
     (lambda (x y) (tag (mul-rat x y))))

(put 'div '(rational rational)
     (lambda (x y) (tag (div-rat x y))))

(put 'make 'rational
     (lambda (n d) (tag (make-rat n d))))

(put 'equ? '(rational rational) equ?) ; ex-2.79

(put '=zero? '(rational) =zero?) ; ex-2.80

(put 'numer '(rational) numer)

(put 'denom '(rational) denom)


;; testes

(check-equal? (add-rat (make-rat 2 3) (make-rat 1 3))
              (make-rat 1 1))

(check-equal? (sub-rat (make-rat 2 3) (make-rat 1 3))
              (make-rat 1 3))

(check-equal? (mul-rat (make-rat 2 3) (make-rat 1 3))
              (make-rat 2 9))

(check-equal? (div-rat (make-rat 2 3) (make-rat 1 3))
              (make-rat 2 1))

(check-equal? (make-rat 2 3)
              (make-rat 2 3))

(check-equal? (equ? (make-rat 2 3) (make-rat 2 3)) ; ex-2.79
              #t)

(check-equal? (=zero? (make-rat 0 9)) ; ex-2.80
              #t)



#lang racket

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))


;;; contar quantas vezes pode ser dividido por 2 (car) ou 3 (cdr)

(define (car x)
  (define (car-aux x count)
  (if (= 0 (remainder x 2))
      (car-aux (/ x 2) (+ 1 count))
      count))
  (car-aux x 0))

(define (cdr x)
  (define (cdr-aux x count)
  (if (= 0 (remainder x 3))
      (cdr-aux (/ x 3) (+ 1 count))
      count))
  (cdr-aux x 0))


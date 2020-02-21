#lang racket

(define (fibonacci n)
  (cond ((= n 0) 1)
        ((= n 1) 1)
        (else (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))

(define (fibo n)
  (define (aux n a b)
    (if (< n 2)
        a
        (aux (- n 1) (+ a b) a)))
  (aux n 1 1))

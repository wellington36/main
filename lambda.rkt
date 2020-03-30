#lang racket

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


(define (sum-cubes a b)
  (sum (lambda (n) (* n n n))
       a
       (lambda (n) (+ n 1))
       b))

(define (sum-integers a b)
  (sum (lambda (n) n)
       a
       (lambda (n) (+ n 1))
       b))


(define (integral f a b dx)
  (* (sum f (+ a (/ dx 2.0)) (lambda (x) (+ x dx)) b)
     dx))



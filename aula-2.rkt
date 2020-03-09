#lang racket

(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define a 12)

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(sum-of-squares (+ a 1) (* a 2)) =
 (+ (square (+ a 1)) (square (* a 2))) =
  (+ (* (+ a 1) (+ a 1)) (* (* a 2) (* a 2))) =

(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))

(define (abs1 x)
  (cond ((< x 0) (- x))
        (else x)))

(define (abs2 x)
  (if (< x 0)
      (- x) (+ x 1)
      x)z)


;; (define (mycond a b c)
;;   ...)

;; (mycond ((> x 0) x)
;;         ((= x 0) 0)
;;         ((< x 0) (- x))))


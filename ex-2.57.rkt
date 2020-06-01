#lang racket

(require "interfaces.rkt")

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else
         `(+ ,a1 ,a2))))

(define (addend s) (cadr s))

(define (augend s)
   (accumulate make-sum 0 (cddr s)))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))


(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2))
         (* m1 m2))
        (else `(* ,m1 ,m2))))

(define (multiplier p) (cadr p))

(define (multiplicand p)
  (accumulate make-product 1 (cddr  p)))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (make-exponentiation base exp)
  (cond ([=number? exp 0] 1)
	([=number? exp 1] base)
	([and (number? base) (number? exp)] (expt base exp))
	(else `(** ,base ,exp))))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
	((exponentiation? exp)
	 (make-product
	   (make-product
	     (exponent exp)
	     (make-exponentiation (base exp) (make-sum
					       (exponent exp)
					       -1)))
	   (deriv (base exp) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))



;; testes

(deriv '(** x (+ x y)) 'x)
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* x y (+ x 3)) 'x)
(deriv '(* x y (+ x (* 2 4 x) 3)) 'x)




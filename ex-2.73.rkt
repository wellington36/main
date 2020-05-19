#lang racket

(require "table.rkt")

;; Algumas funções necessarias:

(define (square v) (make-product v v))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sub a1 a2)
  (cond ((=number? a1 0) (- 0 a2))
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (- a1 a2))
        (else (list '- a1 a2))))

(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (addend s) (car s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (car p))

(define (multiplicand p) (cadr p))

(define (augend s) (cadr s))



;(define (deriv exp var)
;  (cond ((number? exp) 0)
;        ((variable? exp)
;         (if (same-variable? exp var) 1 0))
;        ((sum? exp)
;         (make-sum (deriv (addend exp) var)
;                   (deriv (augend exp) var)))
;        ((product? exp)
;         (make-sum (make-product
;                    (multiplier exp)
;                    (deriv (multiplicand exp) var))
;                   (make-product
;                    (deriv (multiplier exp) var)
;                    (multiplicand exp))))
;        ;⟨more rules can be added here⟩
;        (else (error "unknown expression type:
;                     DERIV" exp))))

;; nova inprementação

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; item A

; Não é possível assimilar number? e variable?, pois
; só podemos assimilar operações e operandos e number?
; já está definido em racket e variable? vem de symbol?
; que ja está definido no racket.

;; item B

(define (deriv-sum exp var)
  (make-sum (deriv (addend exp) var)
            (deriv (augend exp) var)))

(put 'deriv '+ deriv-sum)

(define (deriv-product exp var)
  (make-sum
   (make-product (multiplier exp)
                 (deriv (multiplicand exp) var))
   (make-product (multiplicand exp)
                 (deriv (multiplier exp) var))))

(put 'deriv '* deriv-product)

; testes

(deriv '(+ x x) 'x)
; 2
(deriv '(* x x) 'x)
; '(+ x x)
(deriv '(+ (* x y) (* x (* x y))) 'x)  
; '(+ y (+ (* x y) (* x y)))

;; item C (farei derivada do quociente)

(define (make-divide p q) (list '/ p q))

(define (numerador exp) (car exp))

(define (denominador exp) (cadr exp))

(define (deriv-quociente exp var)
  (make-divide
   (make-sub
    (make-product (deriv (numerador exp) var)
                  (denominador exp))
    (make-product (numerador exp)
                  (deriv (denominador exp) var)))
   (square (denominador exp))))

(put 'deriv '/ deriv-quociente)

; testes

(deriv '(/ x 8) 'x)
;'(/ 8 64)
(deriv '(/ 8 x) 'x)
; '(/ -8 (* x x))
(deriv '(/ (+ y x) (* x x)) 'x)
; '(/ (- (* x x) (* (+ y x) (+ x x))) (* (* x x) (* x x)))


;; item D

; será nessesario alterar todos os put para que funcione.



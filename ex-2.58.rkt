#lang racket

#|
Alteração na solução do problema 2.56

Define as funções op1 e op2 que retornam o primeiro e o segundo
operando de uma operação. A função "operation" retorna qual é a
operação da expressão. "make-operation" recebe os operandos e a
operação e retorna uma expressão.

Com essas quatro definições é possível alterar a ordem dos operandos e
do operador de uma expressão. Assim a expressão pode ser definida como
'(op1 operation op2) em vez de '(operation op1 op2)

ex: '(* x y) passa a ser '(x * y)
|#

(define (op1 s) (car s))
(define (op2 s) (caddr s))
(define (operation s) (cadr s))

(define (make-expression op1 operation op2)
  `(,op1 ,operation ,op2))

; Essas funções podem ser usadas na solução do problema 2.56

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
         (make-expression a1 '+ a2))))

(define (sum? x)
  (and (pair? x) (eq? (operation x) '+)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2))
         (* m1 m2))
        (else (make-expression m1 '* m2))))

(define (product? x)
  (and (pair? x) (eq? (operation x) '*)))

(define (make-exponentiation base exp)
  (cond ([=number? exp 0] 1)
        ([=number? exp 1] base)
        ([and (number? base) (number? exp)] (expt base exp))
        (else (make-expression base '** exp))))

(define (exponentiation? x)
  (and (pair? x) (eq? (operation x) '**)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (op1 exp) var)
                   (deriv (op2 exp) var)))
        ((product? exp)
         (make-sum
          (make-product (op2 exp)
                        (deriv (op1 exp) var))
          (make-product (deriv (op2 exp) var)
                        (op1 exp)))) 
        ((exponentiation? exp)
         (make-product
          (make-product
           (op2 exp)
           (make-exponentiation (op1 exp) (make-sum
                                           (op2 exp)
                                           -1)))
          (deriv (op1 exp) var)))
        (else
         (error "unknown expression type -- DERIV" exp))))


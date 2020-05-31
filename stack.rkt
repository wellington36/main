#lang racket

(require rackunit)

;;;; stack

(define stack '(1 2 4))

;; cria nova stack usando listas encadeadas como representação
;; make-stack : => stack
(define (make-stack)
  '())

;; recuperar o elemento no topo da stack
;; stack-remove-top : stack => obj
(define (stack-top stack)
  (car stack))

;; retorna nova stack sem o elemento do topo
;; stack-remove-top : stack => stack
(define (stack-remove-top stack)
  (cdr stack))

;; retorna nova stack com o novo elemento no topo
;; stack-remove-top : obj stack => stack
(define (stack-put element stack)
  (cons element stack))

;; testes

(let* ((p0 (make-stack))
       (p1 (stack-put 1 p0))
       (p2 (stack-put 2 p1))
       (p3 (stack-put 3 p2))
       (t1 (stack-top p3))
       (p4 (stack-remove-top p3))       
       (p5 (stack-put 5 p4)))
  (check-equal? t1 3)
  (check-equal? p5 '(5 2 1)))

(provide make-stack stack-top stack-remove-top stack-put)


;;;; fila

;; Sec 3.3.2

#lang racket

;;Autor Caio Lins

;;Tira os elementos repetidos da lista.
(define (make-set lst)
  (define (make-set-iter new-set lst)
    (if (null? lst)
      new-set
      (let ([element (car lst)])
	(make-set-iter (cons element
			     new-set)
		       (filter (lambda (x) (not (= x element))) ;A cada iteração, os elementos
			       (cdr lst))))))			;iguais ao elemento adicionado
  (make-set-iter null lst))					;ao conjunto são excluídos  u- 
								;tilizando o predicado <filter>.
;;Cria um conjunto com os elementos da lista
;;dada e produz os subconjuntos, com uma ló-
;;gica parecida  com  a do <count-change> do 
;;capítulo 1.
(define (subsets s)
  (let ([my-set (make-set s)])					;Criação do conjunto como vari-
    (if (null? my-set)						;ável local.
      (list null)
      (let ((rest (subsets (cdr my-set))))
	(append rest (map (lambda (x)
			    (cons (car my-set)
				  x))
			  rest))))))


;;Testes
;(define my-list (list 1 2 2 3 4))
;(make-set my-list)
;(subsets my-list)

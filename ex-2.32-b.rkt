#lang racket

;; autor Caio Lins

;; tira os elementos repetidos da lista. A cada iteração, os elementos
;; iguais ao elemento adicionado ao conjunto são excluídos utilizando
;; a função <filter>.

(define (make-set lst)
  (define (make-set-iter new-set lst)
    (if (null? lst)
        new-set
        (let ([element (car lst)])
          (make-set-iter (cons element
                               new-set)
                         (filter (lambda (x) (not (= x element))) 
                                 (cdr lst))))))			
  (make-set-iter null lst))					
								

;; cria um conjunto com os elementos da lista dada e produz os
;; subconjuntos, com uma ló- gica parecida com a do <count-change> do
;; capítulo 1.

(define (subsets s)
  (let ([my-set (make-set s)])					
    (if (null? my-set)						
        (list null)
        (let ((rest (subsets (cdr my-set))))
          (append rest (map (lambda (x)
                              (cons (car my-set) x))
                            rest))))))



;; testes

(subsets (make-set (list 1 2 2 3 4)))
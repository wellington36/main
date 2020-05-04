#lang racket

; Exercise 2.32

; Listar os subconjuntos de um dado conjunto (set)

; (1 2 3)
; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

; Basta dar append em duas listas:
; uma com os subsets de (cdr s)
; e outra com esses subsets com o (car s) incluso

; O map é usado para adicionar o (car s)
; em cada elemento dos subsets de (cdr s)

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (elem)
                       (cons (car s) elem))
                     rest)))))

; Essa função trata elementos iguais de uma
; lista como se fossem elementos distintos
; ex: (subsets '(1 1)) -> '(() (1) (1) (1 1))

; É possível transformar uma lista em um
; conjunto removendo os elementos repetidos

; Para isso usamos uma função que verifica se
; um elemento está em uma lista

(define (is-on-list elem list)
  (if (empty? list)
      #f
      (if (= (car list) elem)
          #t
          (is-on-list elem (cdr list)))))

; Nós excluiremos o (car list) do resultado
; se o mesmo estiver no (cdr list)

; Assim, a nossa função (set list) vai removendo
; do começo até o fim da lista os elementos repetidos

(define (set list)
  (if (empty? list)
      '()
      (if (is-on-list (car list) (cdr list))
          (set (cdr list))
          (cons (car list) (set (cdr list))))))

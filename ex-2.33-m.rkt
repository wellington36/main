#lang racket

; Exercise 2.33

; A função accumulate aplica uma operação
; op em todos os elementos de uma lista

; Se op for a operação soma (+) ela irá
; somar todos os elementos da lista
; (accumulate + 0 '(1 2 3)) -> 6

; É necessário um valor inicial para a
; condição de parada, o valor que será
; retornado com a lista vazia

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

; A função map aplica uma operação a
; todos os elementos de uma lista, e
; retorna a lista operada
; (map add1 '(1 2 3)) -> '(2 3 4)

; É possível implementar a função map
; usando a função accumulate

; Para isso o accumulate deve acumular
; uma lista, onde no valor do primeiro
; elemento é aplicada a operação p do map

(define (map p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y))
              null
              sequence))



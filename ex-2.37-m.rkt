#lang racket

; Exercise 2.37

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

; O produto interno de dois vetores v w
; (dot-product v w), é a soma dos produtos
; de cada elemento de v e seu
; correspondente em w

; (map * v w) retornará a lista dos produtos
; elemento a elemento de v e w, e o accumulate
; fará a soma dos elementos dessa lista

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

; Uma matriz pode ser representada como uma
; lista de linhas, cada linha representada
; como uma lista de elementos

(define M '((1 2 3)
            (4 5 6)
            (7 8 9)))

(define v '(4 5 6))

; A multiplicação de uma matriz por um vetor
; é uma coluna com os produtos internos de
; cada linha da matriz pelo vetor

; Usando a função map é possível aplicar
; o produto interno em cada linha da matriz

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

; Exercise 2.36

; O accumulate-n é parecido com a função accumulate,
; porém ela recebe uma lista de sequencias e acumula
; um valor diferente para cada um dos n elementos
; das sequencias, retornando a lista de valores

; ex:
; (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9))) -> '(12 15 18)

; acumulou o 12 com a soma 1 + 4 + 7
; acumulou o 15 com a soma 2 + 5 + 8
; acumulou o 18 com a soma 3 + 6 + 9

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


; Passando o cons para o accumulate-n, o valor
; acumulado será a lista com o n-ézimo elemento
; de cada sequencia

; Assim é possível trocar as linhas pelas colunas
; da representação da matriz

; ex:
; (transpose M) -> '((1 4 7) (2 5 8) (3 6 9))

(define (transpose mat)
  (accumulate-n cons null mat))

; Para multiplicar uma matriz m por uma matriz n
; basta multiplicar cada linha de m pelas colunas
; de n

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector cols x)) m)))


#lang racket

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let* ((left-size      (quotient (- n 1) 2))
             (left-result    (partial-tree elts left-size))
             (left-tree      (car left-result))
             (non-left-elts  (cdr left-result))
             (right-size     (- n (+ left-size 1)))
             (this-entry     (car non-left-elts))
             (right-result   (partial-tree (cdr non-left-elts) right-size))
             (right-tree     (car right-result))
             (remaining-elts (cdr right-result)))
        (cons (make-tree this-entry left-tree right-tree)
              remaining-elts))))

;; item A

(list->tree '(1 3 5 7 9 11))
; '(5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))

; A função constroi uma árvore onde cada nó se divide em 3
; segmentos, onde o primeiro segmento tera o elemento central
; da lista o segundo repitira a função com os elementos
; anteriores ao central e o terceiro aplicara a função nos
; elementos após o elemento central, de forma recursiva.

; Quanto a escolha do elemento central se a lista tem um
; número ímpar de elementos será o do meio, caso tenha n=2k
; elementos será o elemento da possição k.

;; item B

; Note que, partial-tree faz uma recurção quebrando a lista
; em outras 2, ou seja, list->tree é O(logn).




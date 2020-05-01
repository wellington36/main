#lang racket

;;autor: caio lins

(define (reverse1 seq)
  (foldr (lambda (x y) (append y (list x))) null seq))

(define (reverse2 seq)
  (foldl (lambda (x y) (cons x y)) null seq))

;;teste
;(define lst (list 1 2 3 4 5))
;(reverse1 lst)
;(reverse2 lst)

;;modelo de substituição para o foldr:
;(foldr p initial (list 1 2 3 4)) = (p 1 (p 2 (p 3 (p 4 initial))))

;;modelo de substituição para o foldl:
;(foldl p initial (list 1 2 3 4)) = (p 4 (p 3 (p 2 (p 1 initial))))


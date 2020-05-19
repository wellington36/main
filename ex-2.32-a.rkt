#lang racket

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(define (is-in? elt lst) ;recebe um elemento e uma lista e responde (com boolean) se o elemento está na lista
  (pair? (filter (λ (x) (equal? x elt)) lst)))

(define (any-of-in? lst1 lst2) ;recebe duas listas e responde (com boolean) se elas tem algum elemento em comum
  (pair? (filter (λ (x) (is-in? x lst1)) lst2)))

(define (true-subsets l) ;subsets aprimorado

(define (aux-t-sub lsub) ;recebe uma lista de subconjuntos da subsets (lsub) e retorna a lista com a remoção dos subconjuntos repetidos
  (cond ((empty? lsub) empty)
        ((any-of-in? (permutations (car lsub)) (cdr lsub)) (aux-t-sub (cdr lsub)))
        (#t (cons (car lsub) (aux-t-sub (cdr lsub))))))
  
  (aux-t-sub (subsets l)))

;;ctrl C ctrl V permutations

(define (flatmap proc seq)
  (foldr append null (map proc seq)))

(define (permutations s)
  (if (null? s)                    ; empty set?
      (list null)                   ; sequence containing empty set
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

;;(true-subsets (list 1 2 1 3))
;;(true-subsets (list 1 4 1 1))

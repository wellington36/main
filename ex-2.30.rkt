#lang racket

(define (square n) (* n n))

(define (square-tree tree)
  (cond ((null? tree) empty)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-1 tree)
  (map (lambda (n)
         (if (pair? n)
             (square-tree-1 n)
             (square n)))
       tree))


(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(square-tree-1
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
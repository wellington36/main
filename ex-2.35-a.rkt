#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-tree tree) 
  (cond ((null? tree) empty) 
        ((not (pair? tree)) (list tree)) 
        (else (append (enumerate-tree (car tree)) 
                      (enumerate-tree (cdr tree)))))) 

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree t))))
  
;; teste
(enumerate-tree '(1 (2 3) (8 9)))
(count-leaves '(1 (2 3) (8 9)))



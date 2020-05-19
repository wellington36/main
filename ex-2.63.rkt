#lang racket

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))


(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
	      (cons (entry tree)
		    (tree->list-1
		      (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
	result-list
	(copy-to-list (left-branch tree)
		      (cons (entry tree)
			    (copy-to-list
			      (right-branch tree)
			      result-list)))))
  (copy-to-list tree '())) 


(define tree1 (make-tree 4
                         (make-tree 2
                                    (make-tree 1 (make-tree 0 null null) empty)
                                    (make-tree 3 null null))
                         (make-tree 7
                                    (make-tree 5 null null)
                                    (make-tree 9 null null))))

(define tree2 (make-tree 7
                         (make-tree 3
                                    (make-tree 1 null null)
                                    (make-tree 5 null null))
                         (make-tree 9
                                    null
                                    (make-tree 11 null null))))

(define tree3 (make-tree 3
                         (make-tree 1 null null)
                         (make-tree 7
                                    (make-tree 5 null null)
                                    (make-tree 9
                                               null
                                               (make-tree 11 null null)))))

(define tree4 (make-tree 5
                         (make-tree 3
                                    (make-tree 1 null null)
                                    null)
                         (make-tree 9
                                    (make-tree 7 null null)
                                    (make-tree 11 null null))))


(define tree5 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))


(define (test)
  (map (lambda (v) (list v (tree->list-1 (eval v)) (tree->list-2 (eval v))))
       '(tree4 tree3 tree2 tree5)))





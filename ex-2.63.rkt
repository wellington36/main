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

(define (copy-to-list tree result-list)
    (if (null? tree)
	result-list
	(copy-to-list (left-branch tree)
		      (cons (entry tree)
			    (copy-to-list
			      (right-branch tree)
			      result-list)))))
;testes
;(define tree1 
;  (make-tree 4
;	     (make-tree 2
;			(make-tree 1
;				   (make-tree 0
;					      null
;					      null)
;				   empty)
;			(make-tree 3
;				   null
;				   null))
;	     (make-tree 7
;			(make-tree 5
;				   null
;				   null)
;			(make-tree 9
;				   null
;				   null))))
;
;(define tree2 
;  (make-tree 7
;	     (make-tree 3
;			(make-tree 1
;				   null
;				   null)
;			(make-tree 5
;				   null
;				   null))
;	     (make-tree 9
;			null
;			(make-tree 11
;				   null
;				   null))))
;
;(define tree3 
;  (make-tree 3
;	     (make-tree 1
;			null
;			null)
;	     (make-tree 7
;			(make-tree 5
;				   null
;				   null)
;			(make-tree 9
;				   null
;				   (make-tree 11
;					      null
;					      null)))))
;
;(define tree4 
;  (make-tree 5
;	     (make-tree 3
;			(make-tree 1
;				   null
;				   null)
;			null)
;	     (make-tree 9
;			(make-tree 7
;				   null
;				   null)
;			(make-tree 11
;				   null
;				   null))))
;
;(tree->list-1 tree4)
;(tree->list-2 tree4)
;
;(tree->list-1 tree3)
;(tree->list-2 tree3)
;
;(tree->list-1 tree2)
;(tree->list-2 tree2)


;------------------Modelo de substituição para tree->list-1--------------------
;
;(tree->list-1 (make-tree 7
;			(make-tree 3
;				   (make-tree 1
;					      null
;					      null)
;				   (make-tree 5
;					      null
;					      null))
;			(make-tree 9
;				   null
;				   (make-tree 11
;					      null
;					      null))))
;
;(append (tree->list-1 (make-tree 3
;				 (make-tree 1
;					    null
;					    null)
;				 (make-tree 5
;					    null
;					    null)))
;	(cons 7
;	      (tree->list-1 (make-tree 9
;				       null
;				       (make-tree 11
;						  null
;						  null)))))
;
;(append (append (tree->list-1 (make-tree 1
;					 null
;					 null))
;		(cons 3 
;		      (tree->list-1 (make-tree 5
;					       null
;					       null)))
;		(cons 7
;		      (append (tree->list-1 null)
;			      (cons 9
;				    (tree->list-1 (make-tree 11
;							     null
;							     null)))))))
;
;(append (append (append null
;			(cons 1
;			      (tree->list-1 null)))
;		(cons 3 
;		      (append null
;			      (cons 5
;				    (tree->list-1 null))))
;		(cons 7
;		      (append (tree->list-1 null)
;			      (cons 9
;				    (append null
;					    (cons 11
;						  (tree->list-1 null))))))))
;
;(append (append (append null
;			(cons 1
;			      null))
;		(cons 3 
;		      (append null
;			      (cons 5
;				    null)))
;		(cons 7
;		      (append null
;			      (cons 9
;				    (append null
;					    (cons 11
;						  null)))))))
;	     

;--------------------Modelo de substituição para copy-to-list------------------
;----------------------utilizando uma árvore simples---------------------------
;(copy-to-list (make-tree 4 null null) 
;	      null)
;
;(copy-to-list null
;	      (cons 4
;		    (copy-to-list null
;				  null)))
;
;(cons 4 null)
;-------------------------utilizando um árvore maior---------------------------
;(copy-to-list (make-tree 4
;			 (make-tree 3
;				    null
;				    null)
;			 (make-tree 5
;				    null
;				    null))
;	      null)
;
;(copy-to-list (make-tree 3
;			 null
;			 null)
;	      (cons 4 (copy-to-list (make-tree 5
;					       null
;					       null)
;				    null)))
;
;(copy-to-list null
;	      (cons 3 
;		    (copy-to-list null
;				  (cons 4 
;					(copy-to-list (make-tree 5
;								 null
;								 null)
;							null)))))
;
;(copy-to-list null
;	      (cons 3 
;		    (copy-to-list null
;				  (cons 4 
;					(copy-to-list null
;						      (cons 5 
;							    (copy-to-list null
;									  null)))))))
;----------------utilizando um dos exemplos do livro---------------------------
;(copy-to-list (make-tree 7
;			 (make-tree 3
;				    (make-tree 1
;					       null
;					       null)
;				    (make-tree 5
;					       null
;					       null))
;			 (make-tree 9
;				    null
;				    (make-tree 11
;					       null
;					       null)))
;	      null)
;
;(copy-to-list (make-tree 3
;			 (make-tree 1
;				    null
;				    null)
;			 (make-tree 5
;				    null
;				    null))
;
;	      (cons 7 
;		    (copy-to-list (make-tree 9
;					     null
;					     (make-tree 11
;							null
;							null))
;				  null)))
;
;(copy-to-list (make-tree 1
;			 null
;			 null)
;	      (cons 3 
;		    (copy-to-list (make-tree 5
;					     null
;					     null)
;				  (cons 7 
;					(copy-to-list (make-tree 9
;								 null
;								 (make-tree 11
;									    null
;									    null))
;						      null)))))
;
;(copy-to-list (make-tree 1
;			 null
;			 null)
;	      (cons 3 
;		    (copy-to-list (make-tree 5
;					     null
;					     null)
;				  (cons 7 
;					(copy-to-list null
;						      (cons 9 (copy-to-list (make-tree 11
;										       null
;										       null)
;									    null)))))))
;
;(copy-to-list null
;	      (cons 1
;		    (copy-to-list null
;				  (cons 3 
;					(copy-to-list null
;						      (cons 5
;							    (copy-to-list null
;									  (cons 7 
;										(copy-to-list null
;											      (cons 9 (copy-to-list null
;														    (cons 11
;															  (copy-to-list null
;																	null)))))))))))))


(provide entry left-branch right-branch make-tree tree->list-2)

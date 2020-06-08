#lang racket

(require rackunit)

#|
Check whether a given term represents a binary tree
Write a predicate istree which returns true if and only if its argument is a list representing a binary tree.
Example:
* (istree (a (b nil nil) nil))
T
* (istree (a (b nil nil)))
NIL
|#

(define (istree lst)
  (cond ((not (= (length lst) 3)) false)
        ((and (not (pair? (car lst)))
              (eq? 'null (cadr lst))
              (eq? 'null (caddr lst)))
         true)
        ((pair? (car lst))
         false)
        ((eq? 'null (cadr lst))
         (istree (caddr lst)))
        ((eq? 'null (caddr lst))
         (istree (cadr lst)))
        (else (and (istree (cadr lst))
                   (istree (caddr lst))))))

(provide istree)

(check-equal? (istree '(a (b null null) null))
              true)
(check-equal? (istree '(a (b null null)))
              false)
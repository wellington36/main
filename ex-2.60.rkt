#lang racket

(define (element-of-set? x set)
  (cond ((empty? set) false)
        ((equal? x (car set)) true)
        (else
         (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-sets set1 set2)
  (append set1 set2))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)        
         (cons (car set1)
               (intersection-set (cdr set1)  set2)))
        (else
         (intersection-set (cdr set1) set2))))


;; testes

(element-of-set? 3 '( 1 2 2 4 4 3 3 2))

(adjoin-set 2 '( 0 1 3 1 2 ))

(union-sets '( 1 2 2 2 1 ) '( 0 3 4 3 0))

(intersection-set '( 1 2 2 3 2 1) '( 0 1 1 2 3 3))

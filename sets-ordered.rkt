#lang racket

;; implementation of sets as ordered lists

;; average n/2 number of steps
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false) ; stop here
        (else (element-of-set? x (cdr set)))))


(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))


;; O(n) ao inves de O(n^2)
(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()    
      (let ((a (car set1))
            (b (car set2)))
        (cond ((= a b)
               (cons x1
                     (intersection-set (cdr set1) (cdr set2))))
              ((< a b)
               (intersection-set (cdr set1) set2))
              ((< a b)
               (intersection-set set1 (cdr set2)))))))


(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((a (car set1))
                    (b (car set2)))
                (cond ((= a b)
                      (cons (car set1) (union-set (cdr set1) (cdr set2))))
                     ((< a b)
                      (cons a (union-set (cdr set1) set2)))
                     (else
                      (cons b (union-set set1 (cdr set2)))))))))


(provide element-of-set? adjoin-set intersection-set)

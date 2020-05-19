#lang racket

(define (union-set set-1 set-2)
  (cond ((null? set-1) set-2)
        ((null? set-2) set-1)
        ((< (car set-1) (car set-2))
         (cons (car set-1) (union-set (cdr set-1) set-2)))
        ((> (car set-1) (car set-2))
         (cons (car set-2) (union-set set-1 (cdr set-2))))
        (else
         (cons (car set-1) (union-set (cdr set-1) (cdr set-2))))))

(union-set (list 1 2 3) (list 5 6 7 10))

(union-set (list 1 3 5 7) (list 2 4 6 8))
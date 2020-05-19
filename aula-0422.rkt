#lang racket

(define (scale-list1 items factor)
  (if (null? items)
      empty
      (cons (* (car items) factor)
            (scale-list1 (cdr items) factor))))

(define (scale-list items factor)
  (map (lambda (n) (* n factor)) items))

(define (square-list1 items)
  (if (null? items)
      empty
      (cons (* (car items) (car items))
            (square-list1 (cdr items)))))

(define (square-list items)
  (map (lambda (n) (* n n)) items))

;; generalizar

(define (map proc items)
  (if (null? items)
      empty
      (cons (proc (car items))
            (map proc (cdr items)))))




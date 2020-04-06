#lang racket

(define (reverse l)
  (if (empty? l)
      l
      (append (reverse (cdr l)) (list (car l)))))


(define (reverse1 l)
  (define (aux ...)
    ...)
  (aux ...))


(reverse (list 1 4 9 16 25))
(reverse '())
(reverse (list 1))

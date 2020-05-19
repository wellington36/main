#lang racket

(define (element-at alist n)
  (if (equal? n 1)
      (car alist)
      (element-at (cdr alist) (- n 1))))

(element-at '(a b c d e) 3)

(provide element-at)

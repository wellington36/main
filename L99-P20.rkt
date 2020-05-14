#lang racket

(define (remove-at alist p)
  (define (aux alist before n)
    (cond ((empty? alist) (reverse before))
          ((equal? n p)
           (append (reverse before) (cdr alist)))
          ((< n p)
           (aux (cdr alist) (cons (car alist) before) (+ n 1)))))
  (aux alist empty 1))

(provide remove-at)

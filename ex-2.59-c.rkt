#lang racket

; (andmap f lst) = (foldl and #t lst)
; (ormap f lst)  = (foldl or #f lst)

(define (union-set set0 set1)
  (append set0 (filter (lambda (x)
                         (andmap (lambda (y)
                                   (not (equal? x y)))
                                 set0))
                       set1)))

(union-set (list 1 2 3) (list 4 5 6))
(union-set (list 1 2 3) (list 4 3 5 6))
(union-set (list)       (list 4 5 6))
(union-set (list 1 2 3) (list))
(union-set (list)       (list))

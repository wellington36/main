#lang racket 

; eliminate consecutive duplicates of list elements

(require rackunit)

(define (compress lst)
  (cond ((null? (cdr lst))
         lst)
        ((equal? (car lst) (cadr lst))
         (compress (cdr lst)))
        (else (cons (car lst)
                    (compress (cdr lst))))))

(provide compress)

(check-equal? (compress '(a a a a b c c a a d e e e e))
              '(a b c a d e))

#lang racket

(require rackunit)

; Replicate the elements of a list a given number of times

(define (repli lst n)
  (define (repli-aux lst n answer)
    (if (empty? lst)
        answer
        (repli-aux (cdr lst) n (append answer
                                       (make-list n (car lst))))))
  (repli-aux lst n empty))

(check-equal? (repli '(a b c) 3) '(a a a b b b c c c))

(check-equal? (repli '(a b c d) 2) '(a a b b c c d d))
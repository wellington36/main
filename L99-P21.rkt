#lang racket

(require rackunit)

; Insert an element at a given position into a list

(define (insert-at elmt lst pst)
  (if (or (empty? lst) (= pst 1))
      (cons elmt lst)
      (cons (car lst)
            (insert-at elmt (cdr lst) (- pst 1)))))

(check-equal? (insert-at 'alfa '(a b c d) 2)
              '(a alfa b c d))

(check-equal? (insert-at 'beta '(a b c) 4)
              '(a b c beta))
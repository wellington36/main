#lang racket

(require rackunit)

#|
Split a list into two parts; the length of the first part is given.
Do not use any predefined predicates.

Example:
* (split '(a b c d e f g h i k) 3)
((A B C) (D E F G H I K))
|#

(define (split lst n)
  (list (reverse (list-tail (reverse lst)
                            (- (length lst) n)))
        (list-tail lst n)))

(provide split)

(check-equal? (split '(a b c d e f g h i k) 3)
              '((a b c) (d e f g h i k)))



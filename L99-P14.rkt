#lang racket

(require rackunit)

#|

https://bit.ly/3cUFT0E
https://docs.racket-lang.org/rackunit/

duplicate the elements of a list.

Example:
* (dupli '(a b c c d))
(A A B B C C C C D D)


|#

(define (dupli a-list)
  (if (empty? a-list)
      '()
      (cons (car a-list) (cons (car a-list)
                               (dupli (cdr a-list))))))


(check-equal? (dupli '(a b c c d)) '(a a b b c c c c d d))
(check-equal? (dupli '()) '())

(provide dupli)

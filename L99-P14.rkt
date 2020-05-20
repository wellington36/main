#lang racket

#|

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

(provide dupli)


(dupli '(a b c c d))

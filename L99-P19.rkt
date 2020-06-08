#lang racket

(require rackunit)

#|
Rotate a list N places to the left.
Examples:
* (rotate '(a b c d e f g h) 3)
(D E F G H A B C)

* (rotate '(a b c d e f g h) -2)
(G H A B C D E F)
|#

(define (rotate lst n)
  (cond ((= n 0) lst)
        ((> n 0) (reverse (rotate* lst (remainder n (length lst)))))
        ((< n 0) (rotate lst (+ (length lst) n)))))

(define (rotate* lst n)
  (append (list-tail (reverse lst)
                     (- (length lst) n))
          (reverse (list-tail lst n))))
      
(provide rotate)

(check-equal? (rotate '(a b c d e f g h) 3)
              '(d e f g h a b c))

(check-equal? (rotate '(a b c d e f g h) -2)
              '(g h a b c d e f))
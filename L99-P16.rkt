#lang racket

(require rackunit)

#|

Drop every N'th element from a list.

Example:
* (drop '(a b c d e f g h i k) 3)
(A B D E G H K)

|#

(define (drop a-list n)
  (define (drop-aux a-list r-list n)
    (cond ((empty? a-list) r-list)
          ((= n 0) r-list)
          (else (drop-aux (cdr a-list)
                          (append  r-list (list (car a-list)))
                          (- n 1)))))
  (drop-aux a-list '() n))

(provide drop)

(check-equal? (drop '(a b c d e f g h i k) 3)
              '(a b d e g h k))


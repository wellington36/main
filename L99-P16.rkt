#lang racket

(require rackunit)

#|

Drop every N'th element from a list.

|#


(define (drop list n)
  (define (drop-aux list n i)
    (if (empty? list)
        '()
        (cond ((< i n) (cons (car list) (drop-aux (cdr list) n (+ 1 i))))
              (else (drop-aux (cdr list) n 1)))))
  (drop-aux list n 1))


(provide drop)


;Tests

(check-equal? (drop '(a b c d e f g h i k) 3)
              '(a b d e g h k))

(check-equal? (drop '(1 2 3) 2)
              '(1 3))


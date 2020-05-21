#lang racket

(require rackunit)

; Given two indices, I and K, the slice is the list containing the
; elements between the I'th and K'th element of the original list
; (both limits included).  Start counting the elements with 1.

; Example:
; * (slice '(a b c d e f g h i k) 3 7)
; (C D E F G)


(define (select list n)
  (if (or (= n 0) (null? list)) empty
      (cons (car list) (select (cdr list) (- n 1)))))

(define (slice list i k)
  (cond ((empty? list) empty)
        ((= i 1) (slice list 0 k))
        ((> i 1) (slice  (cdr list) (- i 1) (- k 1)))
        (else (select list k))))

(check-equal? (slice '(a b c d e f g h i k) 3 7)
              '(c d e f g))

(check-equal? (slice '(a b c d e f g h i k l m n o) 4 9)
              '(d e f g h i))

(provide slice)




#lang racket

(require rackunit)
(require "L99-P40-a.rkt")

;Given a range of integers by its lower and upper limit, print a list of all even numbers and their Goldbach
;composition.

;Example:
;(goldbach-list 9 20)

;10 = 3 + 7
;12 = 5 + 7
;14 = 3 + 11
;16 = 3 + 13
;18 = 5 + 13
;20 = 3 + 17

; In most cases, if an even number is written as the sum of two prime numbers, one of them is very small.
;Very rarely, the primes are both bigger than say 50. Try to find out how many such cases there are in the
;range 2..3000.

;Example (for a print limit of 50):
;(goldbach-list 1 2000 50)
;992 = 73 + 919
;1382 = 61 + 1321
;1856 = 67 + 1789
;1928 = 61 + 1867

(define (golbach-list x . y)
  (aux-golbach (lst x y)))

(define (aux-golbach lst)
  (cond ((null? lst) (newline))
        (else ((λ (x y) (printf "~a = ~a + ~a\n" (+ x y) x y )) (car lst)(cadr lst))
              (aux-golbach (cddr lst)))))

(define (assf-all-lst proc lst)
  (let ([x (assf proc lst)])
    (if x (append (assf proc lst) (assf-all-lst proc (remove x lst)))
        '())))

(define (lst x y)
  (if (null? (cdr y))
      (append* (map (λ (x) (goldbach x)) (filter even? (range x (+ (car y) 1)))))
      (assf-all-lst (λ (n) (> n (cadr y)))
                    (map (λ (x) (goldbach x))
                         (filter (lambda (x) (and (even? x) (> x 2)))
                                 (range x (+ (car y) 1)))))))

(golbach-list 10 20)
(golbach-list 1 2000 50)

(provide golbach-list)



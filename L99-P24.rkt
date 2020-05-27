#lang racket

;P24 - 99 problems
;sorteia n números de 1 a m

(define (lotto n m)
  (extract (aux1 (list) n m)))

 (define (aux1 lst n m)
   (if (= (length lst) n)
                        lst 
                       (cons (+ (random m) 1) (aux1 lst (- n 1) m))))


(define (extract lst)
  (for-each (λ (x) (printf "~a " x)) lst))

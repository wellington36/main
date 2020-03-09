#lang racket

(require racket/trace)

(define (factorial1 n)
  (if (= n 1)
      1
      (* n (factorial1 (- n 1)))))


(define (factorial2 n)
  (define (fact-iter product counter)
    (if (> counter n)
      product
      (fact-iter (* counter product)
                 (+ counter 1))))
  (fact-iter 1 1))

(trace factorial1 factorial2)




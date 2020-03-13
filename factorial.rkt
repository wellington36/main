#lang racket

(require racket/trace)

(define (factorial1 n)
  (if (= n 1)
      1
      (* n (factorial1 (- n 1)))))


(define (fact-iter n product counter)
    (if (> counter n)
        product
        (fact-iter n
                   (* counter product)
                   (+ counter 1))))

(define (factorial2 n)
  (fact-iter n 1 1))

(trace factorial1 fact-iter)




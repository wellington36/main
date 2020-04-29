#lang racket

;; http://algorithmics.lsi.upc.edu/docs/Dasgupta-Papadimitriou-Vazirani.pdf

(define (fib1 n)
  (cond ((= n 0) 1)
        ((= n 1) 1)
        (else (+ (fib1 (- n 1)) (fib1 (- n 2))))))


(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))


(define (fibo n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))


(provide fib)


#lang racket

(require racket/trace)

(define (factorial-1 n)
  (if (= n 1)
      1
      (* n (factorial-1 (- n 1)))))


(define (fact-iter n product counter)
    (if (> counter n)
        product
        (fact-iter n
                   (* counter product)
                   (+ counter 1))))

(define (factorial-2 n)
  (fact-iter n 1 1))

;; (trace factorial-1 fact-iter)


;; capitulo 3

(define (factorial-3 n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      (if (> counter n)
          product
          (begin 
            (set! product (* counter product))
            (set! counter (+ counter 1))
            (iter))))
    (iter)))

(time (factorial-2 100))
(time (factorial-3 100))
